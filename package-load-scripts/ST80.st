Installer installUrl: 'http://source.squeak.org/trunk/ST80'.
Installer installUrl: 'http://source.squeak.org/trunk/ST80Tools
Installer installUrl: 'http://source.squeak.org/trunk/ST80Tests'.

WorldState addDeferredUIMessage: [ SmalltalkImage current snapshot: true andQuit: true ].
