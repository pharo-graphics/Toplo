Class {
	#name : #ToMultiSelectBarElementSkin,
	#superclass : #ToBasicListElementSkin,
	#category : #'Toplo-Widget-Select-Multi'
}

{ #category : #'event handling' }
ToMultiSelectBarElementSkin >> focusedSkinEvent: anEvent [

	super focusedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: BlBorder empty ]
]

{ #category : #'event handling' }
ToMultiSelectBarElementSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e | 
		e border: BlBorder empty.
		e padding: BlInsets empty.
		e margin: BlInsets empty ]
]

{ #category : #'accessing - shortcuts' }
ToMultiSelectBarElementSkin >> shortcutsToInstallIn: aListElement [

	^ Array streamContents: [ :stream |

		  stream nextPut: (BlShortcutWithAction new
				   combination: BlKeyCombination builder arrowDown build;
				   action: [ :aShortcutEvent :aShortcut |
					   | idx |
					   idx := aListElement selecter nextSelectableIndexToScrollTo.
					   aListElement selecter scrollToDataSourcePosition: idx.
					   aListElement selecter selectOnlyIndex: idx ]).

		  stream nextPut: (BlShortcutWithAction new
				   combination: BlKeyCombination builder arrowUp build;
				   action: [ :aShortcutEvent :aShortcut |
					   | idx |
					   idx := aListElement selecter previousSelectableIndexToScrollTo.
					   aListElement selecter scrollToDataSourcePosition: idx.
					   aListElement selecter selectOnlyIndex: idx ]).

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
						   aListElement selecter scrollToDataSourcePosition: idx ]).

			  stream nextPut: (BlShortcutWithAction new
					   combination: BlKeyCombination builder shift arrowUp build;
					   action: [ :aShortcutEvent :aShortcut |
						   | idx |
						   idx := aListElement selecter previousDeselectedIndex.
						   aListElement selecter selectIndex: idx.
						   aListElement selecter scrollToDataSourcePosition: idx ]) ] ]
]

{ #category : #'event handling' }
ToMultiSelectBarElementSkin >> unfocusedSkinEvent: anEvent [

	super unfocusedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: BlBorder empty ]
]

{ #category : #'event handling' }
ToMultiSelectBarElementSkin >> uninstallSkinEvent: anEvent [

	super uninstallSkinEvent: anEvent.
	anEvent elementDo: [ :e | e uninstallShortcuts ]
]
