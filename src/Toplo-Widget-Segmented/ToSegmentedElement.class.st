Class {
	#name : #ToSegmentedElement,
	#superclass : #ToBarElement,
	#traits : 'TToCheckableGroupHolder',
	#classTraits : 'TToCheckableGroupHolder classTrait',
	#instVars : [
		'group'
	],
	#category : #'Toplo-Widget-Segmented'
}

{ #category : #initialization }
ToSegmentedElement >> defaultInnerContainer [

	^ ToSegmentedInnerBarElement onBarElement: self
]

{ #category : #initialization }
ToSegmentedElement >> defaultNodeManagerClass [ 

	^ ToSegmentManager 
]

{ #category : #initialization }
ToSegmentedElement >> defaultSelectionMode [

	^ ToSegmentedSelectionMode primary
]

{ #category : #initialization }
ToSegmentedElement >> initialize [

	super initialize
]

{ #category : #'t - checkable group holder' }
ToSegmentedElement >> rawGroup [

	^ group ifNil: [ group := ToCheckableGroup new ]
]

{ #category : #'t - checkable group holder' }
ToSegmentedElement >> rawGroup: aGroup [

	self shouldNotImplement 
]

{ #category : #accessing }
ToSegmentedElement >> segmentAccessor [
	"according to the specific vocabulary - the data items are segments of the segmented element "

	^ self dataAccessor
]
