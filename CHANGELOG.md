
#### [Current]

#### 
 * [36a9d02](../../commit/36a9d02) - __(Joshua Hoblitt)__ update raid_check_options example in README
 * [4f6ea9f](../../commit/4f6ea9f) - __(Joshua Hoblitt)__ add commented examples to el5 raid-check template

* to match the style of the current el6 raid-check template

 * [0a7502b](../../commit/0a7502b) - __(Joshua Hoblitt)__ update el6 raid-check template

* add support for the MAXCONCURENT variable introduced in later 6.x mdadm
packages

 * [0a29969](../../commit/0a29969) - __(Joshua Hoblitt)__ fix/suppress linter warnings
 * [5d007ed](../../commit/5d007ed) - __(Joshua Hoblitt)__ add el5.x to README tested platforms
 * [15ae51e](../../commit/15ae51e) - __(Joshua Hoblitt)__ add mdmonitor email address example to README
 * [ef0e227](../../commit/ef0e227) - __(Joshua Hoblitt)__ merge mdadm_config_spec.rb into mdadm_spec.rb

Since we're now only testing the public API of the mdadm class.

 * [5d1b8d3](../../commit/5d1b8d3) - __(Joshua Hoblitt)__ add el5.x support for raid_check_options param to mdadm class
 * [c30edf7](../../commit/c30edf7) - __(Joshua Hoblitt)__ mv all mdadm param defaults to mdadm::params class
 * [9c9b7c7](../../commit/9c9b7c7) - __(Joshua Hoblitt)__ add unit tests of mdadm's service_{ensure,enable} params
 * [7ba06ea](../../commit/7ba06ea) - __(Joshua Hoblitt)__ add raid_check_manage param to mdadm class
 * [f236b7d](../../commit/f236b7d) - __(Joshua Hoblitt)__ fix broken mdadm force_service param and rename it to service_force
 * [73a1f8c](../../commit/73a1f8c) - __(Joshua Hoblitt)__ rename mdadm param config_options -> config_file_options
 * [844aade](../../commit/844aade) - __(Joshua Hoblitt)__ add config_file_manage param to class mdadm
 * [9f785e0](../../commit/9f785e0) - __(Joshua Hoblitt)__ remove API documentation from .pp files

Refer to the README for all parameter documentation.

 * [e80f45a](../../commit/e80f45a) - __(Joshua Hoblitt)__ fail on unsupported $::operatingsystemmajrelease

+ make mdadm::config & mdadm::raid_check private classes

 * [fc1cf37](../../commit/fc1cf37) - __(Joshua Hoblitt)__ fix README example formatting
 * [b90f6fe](../../commit/b90f6fe) - __(Joshua Hoblitt)__ update README ToC
 * [70eaabb](../../commit/70eaabb) - __(Joshua Hoblitt)__ add basic README info
 * [28cecec](../../commit/28cecec) - __(Joshua Hoblitt)__ prune mdadmversion fact value

Instead of returning the literal string returned by `mdadm --version`,
parse out and return only the version number.

 * [a0dbd6b](../../commit/a0dbd6b) - __(Joshua Hoblitt)__ replace rspec-system with beaker
 * [00a6e53](../../commit/00a6e53) - __(Joshua Hoblitt)__ restore travis augeas package setup
 * [788355f](../../commit/788355f) - __(Joshua Hoblitt)__ fixing rspec-puppet to < 1.0

due to these issues:

* https://github.com/domcleal/rspec-puppet-augeas/issues/9
* https://github.com/domcleal/rspec-puppet-augeas/issues/14

 * [826ec4c](../../commit/826ec4c) - __(Joshua Hoblitt)__ update to rspec >= 1 syntax

To suppress:
    DEPRECATION: include_class is deprecated. Use contain_class instead

 * [414fb5d](../../commit/414fb5d) - __(Joshua Hoblitt)__ update copyright notice year (-2014)
 * [f6ac329](../../commit/f6ac329) - __(Joshua Hoblitt)__ update travis matrix
 * [52e57a8](../../commit/52e57a8) - __(Joshua Hoblitt)__ update .gitignore
 * [c53dde2](../../commit/c53dde2) - __(Joshua Hoblitt)__ enable managements of mdmonitor service
 * [bee45b3](../../commit/bee45b3) - __(Joshua Hoblitt)__ validate params to mdadm::raid_check
 * [c90515b](../../commit/c90515b) - __(Joshua Hoblitt)__ change mdadm::config mailaddr param into an hash
 * [d7f1875](../../commit/d7f1875) - __(Joshua Hoblitt)__ mv spec/classes/ -> spec/unit/classes/
 * [5e76a45](../../commit/5e76a45) - __(Joshua Hoblitt)__ add mdadm_arrays fact
 * [172ae55](../../commit/172ae55) - __(Joshua Hoblitt)__ add mdadmversion fact
 * [4675af2](../../commit/4675af2) - __(Joshua Hoblitt)__ ignore git .swp files
 * [54e6247](../../commit/54e6247) - __(Joshua Hoblitt)__ add mdadm fact
 * [1b1e846](../../commit/1b1e846) - __(Joshua Hoblitt)__ stub out mdadm::config class
 * [1ab3714](../../commit/1ab3714) - __(Joshua Hoblitt)__ implement anchor pattern
 * [3938fcf](../../commit/3938fcf) - __(Joshua Hoblitt)__ add mdmonitor service
 * [95bc3f7](../../commit/95bc3f7) - __(Joshua Hoblitt)__ add raid-check configuration
 * [02f858e](../../commit/02f858e) - __(Joshua Hoblitt)__ install mdadm package
 * [8438d72](../../commit/8438d72) - __(Joshua Hoblitt)__ Merge puppet-module_skel
 * [3a20317](../../commit/3a20317) - __(Joshua Hoblitt)__ first commit
