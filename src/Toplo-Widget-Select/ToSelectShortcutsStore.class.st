Class {
	#name : #ToSelectShortcutsStore,
	#superclass : #ToShortcutsStore,
	#category : #'Toplo-Widget-Select-Shortcuts'
}

{ #category : #storing }
ToSelectShortcutsStore >> shortcut: aShortCut in: aSelect [

	aSelect isFiltrable ifTrue: [
		self addInstaller: (ToEditorShortcutsInstaller new
				 shortcut: aShortCut;
				 eventTarget: aSelect filterTextField;
				 yourself).
		^ self ].
	self addInstaller: (ToShortcutsInstaller new
			 shortcut: aShortCut;
			 eventTarget: aSelect;
			 yourself)
]
