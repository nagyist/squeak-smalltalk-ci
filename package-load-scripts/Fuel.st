Installer squeakmap
    update;
    addPackage: 'Fuel (1.9)';
    install.

WorldState addDeferredUIMessage: [ SmalltalkImage current snapshot: true andQuit: true ].
