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

{ #category : #accessing }
ToCheckableBarElement >> checkableElementAccessor [
	"according to the specific vocabulary - the data items are checkables of the checkable bar element "

	^ self dataAccessor
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
