Class {
	#name : #ToListSelectionMode,
	#superclass : #ToListAbstractSelectionMode,
	#instVars : [
		'preserveSelectionOnFocused',
		'installedShortcuts',
		'selectionCommandEventHandler'
	],
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #initialization }
ToListSelectionMode >> initialize [ 

	super initialize.
	preserveSelectionOnFocused := true
]

{ #category : #'api - hooks' }
ToListSelectionMode >> onInstalledIn: anElement [

	super onInstalledIn: anElement. 
	selectionCommandEventHandler := ToSelectionModelCommandEventHandler new.
	anElement addEventHandler: selectionCommandEventHandler.
	installedShortcuts := self shortcutsIn: anElement.
	installedShortcuts do: [ :s | anElement addShortcut: s ]
]

{ #category : #'api - hooks' }
ToListSelectionMode >> onUninstalledIn: anElement [

	installedShortcuts do: [ :s | anElement removeShortcut: s ].
	installedShortcuts := nil.
	anElement removeEventHandler: selectionCommandEventHandler.
	selectionCommandEventHandler := nil.
	super onUninstalledIn: anElement. 

]

{ #category : #accessing }
ToListSelectionMode >> preserveSelectionOnFocused [

	^ preserveSelectionOnFocused
]

{ #category : #accessing }
ToListSelectionMode >> preserveSelectionOnFocused: aBoolean [

	preserveSelectionOnFocused := aBoolean
]

{ #category : #shortcuts }
ToListSelectionMode >> selectNextIn: anElement event: aShortcutEvent [

	self selectionModel goTowardNext ifTrue: [
		self selecter selectOnlyIndex: self selectionModel currentIndex; apply ].
	self selectionModel isEmpty ifTrue: [ ^ self ].
	anElement scrollToIndex: self selectionModel currentIndex
]

{ #category : #shortcuts }
ToListSelectionMode >> selectPreviousIn: anElement event: aShortcutEvent [

	self selectionModel goTowardPrevious ifTrue: [
		self selecter selectOnlyIndex: self selectionModel currentIndex; apply ].
	self selectionModel isEmpty ifTrue: [ ^ self ].
	anElement scrollToIndex: self selectionModel currentIndex
]

{ #category : #shortcuts }
ToListSelectionMode >> shortcutsIn: anElement [

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
