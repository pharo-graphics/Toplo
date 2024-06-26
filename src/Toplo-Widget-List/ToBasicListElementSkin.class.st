Class {
	#name : #ToBasicListElementSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #'event handling' }
ToBasicListElementSkin >> focusedSkinEvent: anEvent [

	super focusedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: (e valueOfTokenNamed: #'color-primary') ]
]

{ #category : #'event handling' }
ToBasicListElementSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e shortcuts: (self shortcutsToInstallIn: e).
		e installShortcuts.
		e border: (e valueOfTokenNamed: #'color-border').
		e background: (e valueOfTokenNamed: #'color-bg-container').
		e padding: (BlInsets
				 horizontal: (e valueOfTokenNamed: #'list-padding-H')
				 vertical: (e valueOfTokenNamed: #'list-padding-V')).
		e geometry: (BlRoundedRectangleGeometry cornerRadius:
				 (e valueOfTokenNamed: 'border-radius')).
		e margin: BlInsets empty.
		e outskirts: BlOutskirts inside ]
]

{ #category : #'accessing - shortcuts' }
ToBasicListElementSkin >> shortcutsToInstallIn: aListElement [

	^ Array streamContents: [ :stream |
		  stream nextPut: (BlShortcutWithAction new
				   combination: BlKeyCombination builder arrowDown build;
				   action: [ :aShortcutEvent :aShortcut |
					   | idx |
					   idx := aListElement selecter nextSelectableIndexToScrollTo.
					   aListElement selecter scrollTowardEndToDataSourcePosition: idx.
					   aListElement selecter selectOnlyIndex: idx ]).

		  stream nextPut: (BlShortcutWithAction new
				   combination: BlKeyCombination builder arrowUp build;
				   action: [ :aShortcutEvent :aShortcut |
					   | idx |
					   idx := aListElement selecter previousSelectableIndexToScrollTo.
					   aListElement selecter scrollTowardStartToDataSourcePosition:
							   idx.
					   aListElement selecter selectOnlyIndex: idx ]) ]
]

{ #category : #'event handling' }
ToBasicListElementSkin >> unfocusedSkinEvent: anEvent [

	super unfocusedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: (e valueOfTokenNamed: #'color-border') ]
]
