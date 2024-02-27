Class {
	#name : #ToListElement,
	#superclass : #ToBasicListElement,
	#instVars : [
		'secondarySelectionModel',
		'secondarySelectionMode'
	],
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #accessing }
ToListElement >> data [

	self
		deprecated: 'Please use dataAccessor instead.'
		transformWith:
			'`@receiver data'
				-> '`@receiver dataAccessor'.
	^ self dataAccessor
]

{ #category : #accessing }
ToListElement >> dataUpdater [

	self
		deprecated: 'Please use dataAccessor instead.'
		transformWith:
			'`@receiver dataUpdater'
				-> '`@receiver dataAccessor'.
	^ self dataAccessor
]

{ #category : #initialization }
ToListElement >> defaultEventHandler [

	^ ToListElementEventHandler new
]

{ #category : #initialization }
ToListElement >> defaultInfiniteElement [

	^ ToObservableCollectionInfiniteElement new
]

{ #category : #initialization }
ToListElement >> defaultSecondarySelectionEventHandler [

	^ ToListSecondarySelectionElementEventHandler new
]

{ #category : #initialization }
ToListElement >> defaultSecondarySelectionMode [

	^ ToListMultipleSelectionMode new operator:
		  (ToSecondarySelectionModelOperator new selectionModel:
			   self secondarySelectionModel)
]

{ #category : #initialization }
ToListElement >> infiniteSharedEvents [

	^ super infiniteSharedEvents, { ToObservableCollectionEvent }
]

{ #category : #initialization }
ToListElement >> initialize [ 

	super initialize.
	self secondarySelectionModel: self newSelectionModel.
	self secondarySelectionMode: self defaultSecondarySelectionMode.
	self addEventHandler: self defaultSecondarySelectionEventHandler
]

{ #category : #skin }
ToListElement >> newRawSkin [ 

	^ ToListElementSkin new
]

{ #category : #accessing }
ToListElement >> secondarySelecter [ 

	^ self secondarySelectionMode selecter
]

{ #category : #accessing }
ToListElement >> secondarySelectionMode [

	^ secondarySelectionMode
]

{ #category : #accessing }
ToListElement >> secondarySelectionMode: aSelectionMode [

	secondarySelectionMode ifNotNil: [ secondarySelectionMode onUninstalledIn: self ].
	secondarySelectionMode := aSelectionMode.
	secondarySelectionMode ifNotNil: [ secondarySelectionMode onInstalledIn: self ].
	self dispatchEvent: ToListSecondarySelectionModeChangedEvent new
]

{ #category : #accessing }
ToListElement >> secondarySelectionModel [

	^ secondarySelectionModel
]

{ #category : #accessing }
ToListElement >> secondarySelectionModel: aSelectionModel [

	secondarySelectionModel ifNotNil: [ secondarySelectionModel onUninstalledIn: self ].
	secondarySelectionModel := aSelectionModel.
	secondarySelectionModel ifNotNil: [secondarySelectionModel onInstalledIn: self ]
]

{ #category : #accessing }
ToListElement >> selectionStrategy [

	self
		deprecated: 'Use selecter instead'
		transformWith: '`@receiver selectionStrategy' -> '`@receiver selecter'.

	^ self selecter
]

{ #category : #accessing }
ToListElement >> shortcutsToInstall [

	^ Array streamContents: [ :stream |
		  stream nextPutAll: super shortcutsToInstall.
		
		  stream nextPut: (BlShortcutWithAction new
				   combination: BlKeyCombination builder arrowDown build;
				   action: [ :aShortcutEvent :aShortcut |
					   | idx |
					   idx := self selecter nextSelectableIndex.
					   self selecter scrollToIndex: idx.
					   self selecter selectOnlyIndex: idx ]).
		  stream nextPut: (BlShortcutWithAction new
				   combination: BlKeyCombination builder arrowUp build;
				   action: [ :aShortcutEvent :aShortcut |
					   | idx |
					   idx := self selecter previousSelectableIndex.
					   self selecter scrollToIndex: idx.
					   self selecter selectOnlyIndex: idx ]).

		  self isMultipleSelection ifTrue: [
			  stream nextPut: (BlShortcutWithAction new
					   combination: BlKeyCombination primaryA;
					   action: [ :aShortcutEvent :aShortcut |
						   self selecter selectAll ]).
			  stream nextPut: (BlShortcutWithAction new
					   combination: BlKeyCombination builder shift arrowDown build;
					   action: [ :aShortcutEvent :aShortcut |
						   | idx |
						   idx := self selecter nextDeselectedIndex.
						   self selecter selectIndex: idx.
						   self selecter scrollToIndex: idx ]).
			  stream nextPut: (BlShortcutWithAction new
					   combination: BlKeyCombination builder shift arrowUp build;
					   action: [ :aShortcutEvent :aShortcut |
						   | idx |
						   idx := self selecter previousDeselectedIndex.
						   self selecter selectIndex: idx.
						   self selecter scrollToIndex: idx ]) ] ]
]
