Class {
	#name : #ToListSelectionRepresentationOption,
	#superclass : #Object,
	#instVars : [
		'selectionOption',
		'currentSelectionRepresentations',
		'consecutiveRefreshCount'
	],
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #'instance creation' }
ToListSelectionRepresentationOption class >> embedded [

	^ ToListSelectionWithoutElementOption new
]

{ #category : #'instance creation' }
ToListSelectionRepresentationOption class >> neighbouring [

	^ ToListSelectionWithNeighboringElementOption new
]

{ #category : #'instance creation' }
ToListSelectionRepresentationOption class >> separate [

	^ ToListSelectionWithSeparateElementOption new
]

{ #category : #'nodes collecting' }
ToListSelectionRepresentationOption >> currentSelectionRepresentationsFrom: aListElement withSelectionModel: aSelectionModel [

	^ self subclassResponsibility 
]

{ #category : #'nodes collecting' }
ToListSelectionRepresentationOption >> forceRefreshSelectionIn: aListElement withSelectionModel: aSelectionModel [

	consecutiveRefreshCount := 0.
	self refreshSelectionIn: aListElement withSelectionModel: aSelectionModel
]

{ #category : #initialization }
ToListSelectionRepresentationOption >> initialize [ 

	super initialize.
	consecutiveRefreshCount := 0.
	currentSelectionRepresentations := #(  )
]

{ #category : #testing }
ToListSelectionRepresentationOption >> isEmbedded [ 

	^ false
]

{ #category : #testing }
ToListSelectionRepresentationOption >> isGrouped [ 

	^ false
]

{ #category : #testing }
ToListSelectionRepresentationOption >> isMasked [

	^ selectionOption isMasked
]

{ #category : #testing }
ToListSelectionRepresentationOption >> isSeparate [

	^ false
]

{ #category : #'nodes collecting' }
ToListSelectionRepresentationOption >> launchUpdateSelectionIn: aListElement withSelectionModel: aSelectionModel [

	| newRepresentations |
	"aListElement selectionModel = aSelectionModel ifTrue: [
		self halt ]."
	newRepresentations := self
		                      currentSelectionRepresentationsFrom:
		                      aListElement
		                      withSelectionModel: aSelectionModel.
	" send deselected even if groups is empty. 
	As an example, if not, if a selected node is turned as unselectable, 
	the content of the node will not be updated correctly 
	because the content skin will not receive the DeselectedSkinEvent "
	aSelectionModel = aListElement selectionModel ifTrue: [
		self notifyNodesDeselectedIn: aListElement ].
	self removeSelectionRepresentationsIn: aListElement.
	currentSelectionRepresentations := newRepresentations.
	^ true
]

{ #category : #'private - selection updating' }
ToListSelectionRepresentationOption >> notifyNodesDeselectedIn: aListElement [

	self triggerSelectionState ifFalse: [ ^ self ].
	aListElement innerElement nodesDo: [ :n |
		n holder notifyDeselectedWithOption: selectionOption ]
]

{ #category : #'private - selection updating' }
ToListSelectionRepresentationOption >> notifyNodesSelectedIn: aListElement [

	self triggerSelectionState ifFalse: [ ^ self ].
	aListElement innerElement nodesDo: [ :n |
		n holder notifySelectedWithOption: selectionOption ]
]

{ #category : #'nodes collecting' }
ToListSelectionRepresentationOption >> refreshSelectionIn: aListElement withSelectionModel: aSelectionModel [

	consecutiveRefreshCount := consecutiveRefreshCount + 1.
	consecutiveRefreshCount > 1 ifTrue: [
		^ self ].
	"self removeSelectionRepresentationsIn: aListElement."
	self
		launchUpdateSelectionIn: aListElement
		withSelectionModel: aSelectionModel
]

{ #category : #removing }
ToListSelectionRepresentationOption >> removeSelectionContainer [
]

{ #category : #removing }
ToListSelectionRepresentationOption >> removeSelectionRepresentationsIn: aListElement [

	currentSelectionRepresentations do: [ :g | g onRemovedFromListElement: aListElement ].
	currentSelectionRepresentations := #()
]

{ #category : #accessing }
ToListSelectionRepresentationOption >> selectionElements [

	^ #(  )
]

{ #category : #accessing }
ToListSelectionRepresentationOption >> selectionOption: aSelectionOption [

	selectionOption := aSelectionOption 
]

{ #category : #'nodes collecting' }
ToListSelectionRepresentationOption >> selectionRepresentationsChangeWith: otherSelectionRepresentationArray [

	currentSelectionRepresentations == otherSelectionRepresentationArray ifTrue: [ ^ false ].
	currentSelectionRepresentations size ~= otherSelectionRepresentationArray size ifTrue: [ ^ true ].
	currentSelectionRepresentations withIndexDo: [ :g :idx |
		g = (otherSelectionRepresentationArray at: idx) ifFalse: [ ^ true ] ].
	^ false
]

{ #category : #accessing }
ToListSelectionRepresentationOption >> triggerSelectionState [

	^ selectionOption triggerSelectionState
]

{ #category : #'nodes collecting' }
ToListSelectionRepresentationOption >> updateSelectionIn: aListElement withSelectionModel: aSelectionModel [

	consecutiveRefreshCount := 0.
	^ self
		  launchUpdateSelectionIn: aListElement
		  withSelectionModel: aSelectionModel
]
