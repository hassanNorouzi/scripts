#!/usr/bin/env perl

use strict;
use warnings;
use WWW::Mechanize;
use constant ROW => 2; # choose that you want the first row or second one!

my $mech = WWW::Mechanize->new();
my $url = "http://reserve.dining.sharif.ir/";

my $user = "signin[username]";
my $pass = "signin[password]";


$mech->post($url);

$mech->submit_form(
    form_number => 1,
    fields => {
	$user => 'YOUR_USERNAME', # change it to your username 
	$pass => 'YOUR_PASSWORD' # change it to your password
    }
    );

$mech->submit_form(
    form_number => 1,
    fields => {
	delivery_id => 2
    }    
    );

my @array = $mech->find_all_links( url_regex => qr/delivery/i );

$mech->follow_link( url => $array[1]->url() );

@array = $mech->find_all_links( url_regex => qr/delivery/i );

$mech->follow_link( url => $array[2]->url() );

my $main_form = $mech->form_number(2);

my @checkboxes = $main_form->find_input(undef,'checkbox');

for(my $i=0; $i<5; $i++){
    if(ROW == 1){
	$checkboxes[2*$i+1]->value(1);
    }
    elsif(ROW == 2){
	$checkboxes[2*$i+2]->value(1);
    }
}

$mech->submit_form(form_number => 2);

#print $mech->content();
