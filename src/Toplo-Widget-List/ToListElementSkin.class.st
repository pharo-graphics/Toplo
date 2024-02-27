Class {
	#name : #ToListElementSkin,
	#superclass : #ToBasicListElementSkin,
	#instVars : [
		'installedShortcuts'
	],
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #'event handling' }
ToListElementSkin >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e | self installShortcutsIn: e ]
]

{ #category : #'accessing - shortcuts' }
ToListElementSkin >> installShortcutsIn: aListElement [

	installedShortcuts := self shortcutsToInstallIn: aListElement.
	installedShortcuts do: [ :sc | aListElement addShortcut: sc ]
]

{ #category : #'accessing - shortcuts' }
ToListElementSkin >> shortcutsToInstallIn: aListElement [

	^ Array streamContents: [ :stream |
		
		  stream nextPut: (BlShortcutWithAction new
				   combination: BlKeyCombination builder arrowDown build;
				   action: [ :aShortcutEvent :aShortcut |
					   | idx |
					   idx := aListElement selecter nextSelectableIndex.
					   aListElement selecter scrollToIndex: idx.
					   aListElement selecter selectOnlyIndex: idx ]).

		  stream nextPut: (BlShortcutWithAction new
				   combination: BlKeyCombination builder arrowUp build;
				   action: [ :aShortcutEvent :aShortcut |
					   | idx |
					   idx := aListElement selecter previousSelectableIndex.
					   aListElement selecter scrollToIndex: idx.
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
						   aListElement selecter scrollToIndex: idx ]).

			  stream nextPut: (BlShortcutWithAction new
					   combination: BlKeyCombination builder shift arrowUp build;
					   action: [ :aShortcutEvent :aShortcut |
						   | idx |
						   idx := aListElement selecter previousDeselectedIndex.
						   aListElement selecter selectIndex: idx.
						   aListElement selecter scrollToIndex: idx ]) ] ]
]

{ #category : #'event handling' }
ToListElementSkin >> uninstallLookEvent: anEvent [

	super uninstallLookEvent: anEvent.
	anEvent elementDo: [ :e | self uninstallShortcutsIn: e ]
]

{ #category : #'accessing - shortcuts' }
ToListElementSkin >> uninstallShortcutsIn: aListElement [

	installedShortcuts do: [ :sc | aListElement removeShortcut: sc ]
]
