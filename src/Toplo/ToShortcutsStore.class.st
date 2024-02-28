Class {
	#name : #ToShortcutsStore,
	#superclass : #Object,
	#instVars : [
		'installers'
	],
	#category : #'Toplo-Core'
}

{ #category : #private }
ToShortcutsStore >> addInstaller: aShortcutInstaller [

	self installers add: aShortcutInstaller
]

{ #category : #initialization }
ToShortcutsStore >> initialize [ 

	super initialize.
	installers := OrderedCollection new
]

{ #category : #'installing - uninstalling' }
ToShortcutsStore >> install [

	self installers do: [ :i | i install ]
]

{ #category : #accessing }
ToShortcutsStore >> installers [

	^ installers
]

{ #category : #storing }
ToShortcutsStore >> shortcut: aShortCut in: anEventTarget [

	self addInstaller: (ToShortcutsInstaller new
			 shortcut: aShortCut;
			 eventTarget: anEventTarget;
			 yourself)
]

{ #category : #'installing - uninstalling' }
ToShortcutsStore >> uninstall [

	self installers do: [ :i | i uninstall ]
]
