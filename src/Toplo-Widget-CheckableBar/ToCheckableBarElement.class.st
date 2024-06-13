Class {
	#name : #ToCheckableBarElement,
	#superclass : #ToBarElement,
	#traits : 'TToCheckableGroupHolder',
	#classTraits : 'TToCheckableGroupHolder classTrait',
	#instVars : [
		'group'
	],
	#category : #'Toplo-Widget-CheckableBar'
}

{ #category : #initialization }
ToCheckableBarElement >> defaultInnerContainer [

	^ ToCheckableInnerBarElement onBarElement: self
]

{ #category : #initialization }
ToCheckableBarElement >> defaultNodeManagerClass [ 

	^ ToCheckableNodeManager 
]

{ #category : #initialization }
ToCheckableBarElement >> defaultSelectionMode [

	^ ToCheckableBarSelectionMode primary
]

{ #category : #'t - checkable group holder' }
ToCheckableBarElement >> rawGroup [

	^ group ifNil: [ group := ToCheckableGroup new ]
]

{ #category : #'t - checkable group holder' }
ToCheckableBarElement >> rawGroup: aGroup [

	self shouldNotImplement 
]

{ #category : #accessing }
ToCheckableBarElement >> segmentAccessor [
	"according to the specific vocabulary - the data items are segments of the segmented element "

	^ self dataAccessor
]
