Class {
	#name : #ToSegmentedElement,
	#superclass : #ToElement,
	#traits : 'TToCheckableGroupHolder',
	#classTraits : 'TToCheckableGroupHolder classTrait',
	#instVars : [
		'bar'
	],
	#category : #'Toplo-Widget-Segmented'
}

{ #category : #accessing }
ToSegmentedElement >> bar [

	^ bar
]

{ #category : #initialization }
ToSegmentedElement >> initialize [ 

	super initialize.
	bar := ToSegmentedBarElement new.
	self addChild: bar
	
]

{ #category : #'t - checkable group holder' }
ToSegmentedElement >> rawGroup [ 

	^ bar rawGroup
]

{ #category : #'t - checkable group holder' }
ToSegmentedElement >> rawGroup: aGroup [

	bar rawGroup: aGroup
]

{ #category : #accessing }
ToSegmentedElement >> segmentAccessor [

	^ bar checkableElementAccessor
]

{ #category : #accessing }
ToSegmentedElement >> selecter [

	^ bar selecter
]

{ #category : #accessing }
ToSegmentedElement >> selectionModel [

	^ bar selectionModel 
]

{ #category : #'t - checkable group holder' }
ToSegmentedElement >> withStrictCheckingStrategy [

	self checkingStrategy: ToCheckableGroupStrictStrategy new
]
