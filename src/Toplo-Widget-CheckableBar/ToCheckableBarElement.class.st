Class {
	#name : #ToCheckableBarElement,
	#superclass : #ToBarElement,
	#traits : 'TToCheckableHolder',
	#classTraits : 'TToCheckableHolder classTrait',
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
ToCheckableBarElement >> defaultEventHandler [

	^ ToCheckableBarEventHandler new
]

{ #category : #initialization }
ToCheckableBarElement >> defaultNodeManagerClass [ 

	^ ToCheckableNodeManager 
]

{ #category : #initialization }
ToCheckableBarElement >> defaultSelectionMode [

	^ ToCheckableBarSelectionMode primary
]

{ #category : #initialization }
ToCheckableBarElement >> initialize [

	super initialize.
	self group
		addEventHandlerOn: ToCheckableGroupChangedEvent
		do: [ :event | self dispatchEvent: event ]
]

{ #category : #'t - checkable holder' }
ToCheckableBarElement >> rawGroup [

	^ group ifNil: [ group := ToCheckableGroup new ]
]

{ #category : #'t - checkable holder' }
ToCheckableBarElement >> rawGroup: aGroup [

	self shouldNotImplement 
]
