Class {
	#name : #ToListSelectionManager,
	#superclass : #ToListAbstractSelectionManager,
	#instVars : [
		'preserveSelectionOnFocused',
		'selectionRequestEventHandler',
		'installedShortcuts'
	],
	#category : #'Toplo-Widget-List-Selection-Model'
}

{ #category : #initialization }
ToListSelectionManager >> initialize [ 

	super initialize.
	preserveSelectionOnFocused := true
]

{ #category : #'api - hooks' }
ToListSelectionManager >> onInstalledIn: anElement [

	super onInstalledIn: anElement. 
	selectionRequestEventHandler := ToSelectionRequestEventHandler new.
	anElement addEventHandler: selectionRequestEventHandler.
	installedShortcuts := self shortcutsIn: anElement.
	installedShortcuts do: [ :s | anElement addShortcut: s ]
]

{ #category : #'api - hooks' }
ToListSelectionManager >> onUninstalledIn: anElement [

	installedShortcuts do: [ :s | anElement removeShortcut: s ].
	installedShortcuts := nil.
	anElement removeEventHandler: selectionRequestEventHandler.
	selectionRequestEventHandler := nil.
	super onUninstalledIn: anElement. 

]

{ #category : #accessing }
ToListSelectionManager >> preserveSelectionOnFocused [

	^ preserveSelectionOnFocused
]

{ #category : #accessing }
ToListSelectionManager >> preserveSelectionOnFocused: aBoolean [

	preserveSelectionOnFocused := aBoolean
]

{ #category : #shortcuts }
ToListSelectionManager >> selectNextIn: anElement event: aShortcutEvent [

	self selecter selectNext.
	self selectionModel isEmpty ifTrue: [ ^ self ].
	anElement scrollToIndex: self selectionModel currentIndex
]

{ #category : #shortcuts }
ToListSelectionManager >> selectPreviousIn: anElement event: aShortcutEvent [

	self selecter selectPrevious.
	self selectionModel isEmpty ifTrue: [ ^ self ].
	anElement scrollToIndex: self selectionModel currentIndex 
]

{ #category : #shortcuts }
ToListSelectionManager >> shortcutsIn: anElement [

	^ {
		  (BlShortcutWithAction new
			   combination: BlKeyCombination builder arrowDown build;
			   action: [ :aShortcutEvent :aShortcut |
				   self selectNextIn: anElement event: aShortcutEvent ]).
		  (BlShortcutWithAction new
			   combination: BlKeyCombination builder arrowUp build;
			   action: [ :aShortcutEvent :aShortcut |
				   self selectPreviousIn: anElement event: aShortcutEvent ]) }
]
