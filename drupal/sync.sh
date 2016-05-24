#!/bin/bash

function basics(){
	drush -y sql-sync @live @$1 --skip-tables-key='test' --structure-tables-key='test'
	mysql denocte_drupal_$1 < ~/tools/drupal/languages_$1.sql
	drush --exact @$1 vset cache 0
	drush --exact @$1 vset preprocess_css 0
	drush --exact @$1 vset preprocess_js 0
	drush --exact @$1 vset page_compression 0
	drush --exact @$1 vset block_cache 0
	drush --exact @$1 vset views_skip_cache 1
	drush --exact @$1 vset file_temporary_path "/home/denocte/tmp/drupal_$1"
	drush --exact @$1 vset error_level 2
}

function smail() {
	drush --exact @$1 vset mimemail_mail "$2"
	drush --exact @$1 vset newsletter_from "$2"
	drush --exact @$1 vset site_mail "$2"
	
}

set -o xtrace

if [ -z "$1" ]
then
	echo Please select target for production sync
else
	
	if [ $1 == 'dev' ]
	then
		#Backup theme_at_kurvendiskussionen_settings from development
		drush vget theme_at_kurvendiskussionen_settings > ~/tools/tmp/theme_at_kurvendiskussionen_settings
		
		#Basic Sync and settings
		basics $1
		drush variable-set site_name "Kurvendiskussionen Dev"
		smail $1 "dev@denocte.canopus.uberspace.de"
		drush --exact @$1 vset piwik_site_id 2
		
		
		#Drop fontyourface tables while they are not in production
		mysql denocte_drupal_$1 -e "drop table fontyourface_font;drop table fontyourface_tag;drop table fontyourface_tag_font;"
		#Enable font your face settings and feature
		drush -y @$1 en features, font_your_face
		
		#Enable at_kurvendiskussionen theme and restore settings
		drush --exact @$1 vset theme_default at_kurvendiskussionen
		sed -i s/'theme_at_kurvendiskussionen_settings: '//g ~/tools/tmp/theme_at_kurvendiskussionen_settings
		php -r "print json_encode($(cat ~/tools/tmp/theme_at_kurvendiskussionen_settings));" | drush vset --format=json theme_at_kurvendiskussionen_settings -
		
		drush @$1 cc all
	elif [ $1 == 'staging' ]
	then
		basics $1
		drush variable-set site_name "Kurvendiskussionen staging"
		smail $1 "staging@denocte.canopus.uberspace.de"
		drush --exact @$1 vset piwik_site_id 3
		drush @$1 cc all
	fi
fi
