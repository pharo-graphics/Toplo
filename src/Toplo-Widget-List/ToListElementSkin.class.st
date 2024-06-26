Class {
	#name : #ToListElementSkin,
	#superclass : #ToBasicListElementSkin,
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #'event handling' }
ToListElementSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |  ]
]

{ #category : #'accessing - shortcuts' }
ToListElementSkin >> shortcutsToInstallIn: aListElement [

	^ Array streamContents: [ :stream |
		
		  stream nextPutAll: (super shortcutsToInstallIn: aListElement).
		
		  aListElement isMultipleSelection ifTrue: [
			  stream nextPut: (BlShortcutWithAction new
					   combination: BlKeyCombination primaryA;
					   action: [ :aShortcutEvent :aShortcut |
						   aListElement selecter selectAll ]).

			  stream nextPut: (BlShortcutWithAction new
					   combination: BlKeyCombination builder shift arrowDown build;
					   action: [ :aShortcutEvent :aShortcut |
						   | idx |
						   idx := aListElement selecter nextDeselectedIndex.
						   aListElement selecter selectIndex: idx.
						   aListElement selecter scrollTowardEndToDataSourcePosition:
								   idx ]).

			  stream nextPut: (BlShortcutWithAction new
					   combination: BlKeyCombination builder shift arrowUp build;
					   action: [ :aShortcutEvent :aShortcut |
						   | idx |
						   idx := aListElement selecter previousDeselectedIndex.
						   aListElement selecter selectIndex: idx.
						   aListElement selecter scrollTowardStartToDataSourcePosition:
								   idx ]) ] ]
]

{ #category : #'event handling' }
ToListElementSkin >> uninstallSkinEvent: anEvent [

	super uninstallSkinEvent: anEvent.
	anEvent elementDo: [ :e | e uninstallShortcuts ]
]
