#!/usr/bin/env perl6
sub MAIN(:$name is copy, :$auth, :$ver, *@, *%) {
    CompUnit::RepositoryRegistry.run-script("lwp-get.pl", :dist-name<LWP::Simple>, :$name, :$auth, :$ver);
}