Class {
	#name : #ToCheckableNode,
	#superclass : #ToBarNode,
	#traits : 'TToCheckable',
	#classTraits : 'TToCheckable classTrait',
	#category : #'Toplo-Widget-CheckableBar'
}

{ #category : #accessing }
ToCheckableNode >> content [ 

	^ self firstChild
]

{ #category : #initialization }
ToCheckableNode >> initialize [

	super initialize.
	self initializeCheckable.
	" in case my content handles a click event (e.g a button), the rule is as follow:
	- if the strategy allows unchecking (None strategy or with weak strategy), then
	the click event is handled normally, the content receives the click event whatever my check state 
	- if the strategy is strict, the click event is handled by the content only in case I'm not yet checked 
	"
	
	"self addEventHandlerOn: ToClickableActionRequestEvent do: [ :event |
			event accept: self isChecked not ]"
]

{ #category : #'t - checkable  - protocol' }
ToCheckableNode >> newCheckableEventHandler [

	^ ToCheckableNodeEventHandler new
]

{ #category : #'t - checkable - accessing' }
ToCheckableNode >> rawChecked [

	^ self holder checked
]

{ #category : #'t - checkable - accessing' }
ToCheckableNode >> rawChecked: anObject [

	self holder checked: anObject
]

{ #category : #'t - checkable - group' }
ToCheckableNode >> rawGroup [

	^ self holder group
]

{ #category : #'t - checkable - group' }
ToCheckableNode >> rawGroup: aGroup [

	self holder group: aGroup
]

{ #category : #'t - checkable - private protocol' }
ToCheckableNode >> switchToNextCheckState [
	" redefined here because the check state is driven by the selection "

	self checked: self isChecked not
]

{ #category : #'t - checkable  - protocol' }
ToCheckableNode >> withIndeterminate [

	^ false
]

{ #category : #'t - checkable  - protocol' }
ToCheckableNode >> withIndeterminate: aBoolean [

	self shouldNotImplement 
]
