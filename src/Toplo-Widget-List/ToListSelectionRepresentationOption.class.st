Class {
	#name : #ToListSelectionRepresentationOption,
	#superclass : #Object,
	#instVars : [
		'selectionOption',
		'currentSelectionGroups'
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
ToListSelectionRepresentationOption >> currentSelectionGroupsFrom: aListElement withSelectionModel: aSelectionModel [

	^ self subclassResponsibility 
]

{ #category : #initialization }
ToListSelectionRepresentationOption >> initialize [ 

	super initialize.
	currentSelectionGroups := #(  )
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

{ #category : #'private - selection updating' }
ToListSelectionRepresentationOption >> notifyNodesDeselectedIn: aListElement [

	self triggerSelectionState ifFalse: [ ^ self ].
	aListElement innerElement nodesDo: [ :n | n holder notifyDeselectedWithOption: self ]
]

{ #category : #'private - selection updating' }
ToListSelectionRepresentationOption >> notifyNodesSelectedIn: aListElement [

	self isMasked ifTrue: [ ^ self ].
	self triggerSelectionState ifFalse: [ ^ self ].
	aListElement innerElement nodesDo: [ :n | n holder notifySelectedWithOption: self ]
]

{ #category : #'nodes collecting' }
ToListSelectionRepresentationOption >> refreshSelectionIn: aListElement withSelectionModel: aSelectionModel [

	self removeSelectionIn: aListElement.
	self
		updateSelectionIn: aListElement
		withSelectionModel: aSelectionModel
]

{ #category : #removing }
ToListSelectionRepresentationOption >> removeSelectionContainer [
]

{ #category : #removing }
ToListSelectionRepresentationOption >> removeSelectionIn: aListElement [

	currentSelectionGroups do: [ :g | g removeSelectionElementIn: aListElement ].
	currentSelectionGroups := #()
]

{ #category : #accessing }
ToListSelectionRepresentationOption >> selectionElements [

	^ #(  )
]

{ #category : #'nodes collecting' }
ToListSelectionRepresentationOption >> selectionGroupsChangeWith: otherSelectionGroupArray [

	currentSelectionGroups == otherSelectionGroupArray ifTrue: [ ^ false ].
	currentSelectionGroups size ~= otherSelectionGroupArray size ifTrue: [ ^ true ].
	currentSelectionGroups withIndexDo: [ :g :idx |
		g = (otherSelectionGroupArray at: idx) ifFalse: [ ^ true ] ].
	^ false
]

{ #category : #accessing }
ToListSelectionRepresentationOption >> selectionOption: aSelectionOption [

	selectionOption := aSelectionOption 
]

{ #category : #accessing }
ToListSelectionRepresentationOption >> triggerSelectionState [

	^ selectionOption triggerSelectionState
]

{ #category : #'nodes collecting' }
ToListSelectionRepresentationOption >> updateSelectionIn: aListElement withSelectionModel: aSelectionModel [

	| newGroups |
	newGroups := self
		             currentSelectionGroupsFrom: aListElement
		             withSelectionModel: aSelectionModel.
	(self selectionGroupsChangeWith: newGroups) ifFalse: [ ^ false ].
	self removeSelectionIn: aListElement.
	currentSelectionGroups := newGroups.
	^ true
]
