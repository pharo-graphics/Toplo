Class {
	#name : #ToBarElementSkin,
	#superclass : #ToBasicListElementSkin,
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #'event handling' }
ToBarElementSkin >> focusedLookEvent: anEvent [

	super focusedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: BlBorder empty ]
]

{ #category : #'event handling' }
ToBarElementSkin >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e padding: BlInsets empty.
		e border: BlBorder empty.
		e margin: BlInsets empty.
		e outskirts: BlOutskirts inside ]
]

{ #category : #'accessing - shortcuts' }
ToBarElementSkin >> shortcutsToInstallIn: aListElement [

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
ToBarElementSkin >> unfocusedLookEvent: anEvent [

	super unfocusedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: BlBorder empty ]
]
