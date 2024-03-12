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
ToListElement >> dataAccessor [

	^ self dataSource
]

{ #category : #initialization }
ToListElement >> defaultDataSource [

	^ ToObservableCollectionInfiniteDataSource new
]

{ #category : #initialization }
ToListElement >> defaultInfiniteElement [

	^ ToInfiniteElement onListElement: self
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

	^ super infiniteSharedEvents , { ToInfiniteScrollFinishedEvent }
]

{ #category : #initialization }
ToListElement >> initialize [

	super initialize.
	self secondarySelectionModel: self newSecondarySelectionModel.
	self secondarySelectionMode: self defaultSecondarySelectionMode.
	self addEventHandler: self defaultSecondarySelectionEventHandler.


]

{ #category : #skin }
ToListElement >> newRawSkin [ 

	^ ToListElementSkin new
]

{ #category : #initialization }
ToListElement >> newSecondarySelectionModel [

	^ ToInteractiveSelectionModel new
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
