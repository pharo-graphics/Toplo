Class {
	#name : #ToListElementSkin,
	#superclass : #ToBasicListElementSkin,
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #'event handling' }
ToListElementSkin >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e | 
		e shortcuts: (self shortcutsToInstallIn: e).
		e installShortcuts ]
]

{ #category : #'accessing - shortcuts' }
ToListElementSkin >> shortcutsToInstallIn: aListElement [

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
					   aListElement selecter scrollTowardStartToDataSourcePosition: idx.
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
						   aListElement selecter scrollTowardEndToDataSourcePosition: idx ]).

			  stream nextPut: (BlShortcutWithAction new
					   combination: BlKeyCombination builder shift arrowUp build;
					   action: [ :aShortcutEvent :aShortcut |
						   | idx |
						   idx := aListElement selecter previousDeselectedIndex.
						   aListElement selecter selectIndex: idx.
						   aListElement selecter scrollTowardStartToDataSourcePosition: idx ]) ] ]
]

{ #category : #'event handling' }
ToListElementSkin >> uninstallLookEvent: anEvent [

	super uninstallLookEvent: anEvent.
	anEvent elementDo: [ :e | e uninstallShortcuts ]
]
