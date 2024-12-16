Class {
	#name : #ToItemListElementSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-List-ItemList'
}

{ #category : #'event handling' }
ToItemListElementSkin >> focusedSkinEvent: anEvent [

	super focusedSkinEvent: anEvent.
	anEvent elementDo: [ :e |  ]
]

{ #category : #'event handling' }
ToItemListElementSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e shortcuts: (self shortcutsToInstallIn: e).
		e installShortcuts.
		e
			withStamp: #background
			do: [ :v | e background: v ]
			ifNone: [
			e background: BlBackground transparent ].
		e padding: (BlInsets
				 horizontal: (e valueOfTokenNamed: #'padding-content-HS')
				 vertical: (e valueOfTokenNamed: #'padding-content-VS')).
		e geometry: (BlRoundedRectangleGeometry cornerRadius:
				 (e valueOfTokenNamed: 'border-radius')) ]
]

{ #category : #'accessing - shortcuts' }
ToItemListElementSkin >> shortcutsToInstallIn: aListElement [

	^ Array streamContents: [ :stream |
		  stream nextPut: (BlShortcutWithAction new
				   combination: BlKeyCombination builder arrowDown build;
				   action: [ :aShortcutEvent :aShortcut |
					   | idx |
					   idx := aListElement secondarySelecter nextSelectableIndexToScrollTo.
					   aListElement secondarySelecter scrollTowardEndToDataSourcePosition: idx.
					   aListElement secondarySelecter selectOnlyIndex: idx ]).

		  stream nextPut: (BlShortcutWithAction new
				   combination: BlKeyCombination builder arrowUp build;
				   action: [ :aShortcutEvent :aShortcut |
					   | idx |
					   idx := aListElement secondarySelecter previousSelectableIndexToScrollTo.
					   aListElement secondarySelecter scrollTowardStartToDataSourcePosition:
							   idx.
					   aListElement secondarySelecter selectOnlyIndex: idx ]) ]
]

{ #category : #'event handling' }
ToItemListElementSkin >> unfocusedSkinEvent: anEvent [

	super unfocusedSkinEvent: anEvent.
	anEvent elementDo: [ :e |  ]
]