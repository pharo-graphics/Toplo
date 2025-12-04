Class {
	#name : #ToFiniteListElementSkin,
	#superclass : #ToBasicListElementSkin,
	#category : #'Toplo-Widget-List-Core-FiniteListElement'
}

{ #category : #'event handling' }
ToFiniteListElementSkin >> focusedSkinEvent: anEvent [

	super focusedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: BlBorder empty ]
]

{ #category : #'event handling' }
ToFiniteListElementSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e padding: (BlInsets all: 1).
		e border: BlBorder empty.
		e margin: BlInsets empty.
		e outskirts: BlOutskirts inside ]
]

{ #category : #'accessing - shortcuts' }
ToFiniteListElementSkin >> shortcutsToInstallIn: aListElement [

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
						   aListElement selecter scrollTowardEndToDataSourcePosition: idx.
						   aListElement selecter selectIndex: idx ]).

			  stream nextPut: (BlShortcutWithAction new
					   combination: BlKeyCombination builder shift arrowUp build;
					   action: [ :aShortcutEvent :aShortcut |
						   | idx |
						   idx := aListElement selecter previousDeselectedIndex.
						   aListElement selecter scrollTowardStartToDataSourcePosition:
								   idx.
						   aListElement selecter selectIndex: idx ]) ] ]
]

{ #category : #'event handling' }
ToFiniteListElementSkin >> unfocusedSkinEvent: anEvent [

	super unfocusedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: BlBorder empty ]
]
