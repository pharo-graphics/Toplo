Class {
	#name : #ToSegment,
	#superclass : #ToBarNode,
	#traits : 'TToCheckable',
	#classTraits : 'TToCheckable classTrait',
	#category : #'Toplo-Widget-Segmented'
}

{ #category : #accessing }
ToSegment >> content [ 

	^ self firstChild
]

{ #category : #initialization }
ToSegment >> initialize [

	super initialize.
	self initializeCheckable.
	" in case my content handles a click event (e.g a button), the rule is as follow:
	- if the strategy allows unchecking (None strategy or with weak strategy), then
	the click event is handled normally, the content receives the click event whatever my check state 
	- if the strategy is strict, the click event is handled by the content only in case I'm not yet checked 
	"
	self addEventFilterOn: BlClickEvent do: [ :event |
		self allowUnchecking ifFalse: [
			self isChecked ifTrue: [ event consume ] ] ]
]

{ #category : #'t - checkable  - protocol' }
ToSegment >> newCheckableEventHandler [

	^ ToSegmentEventHandler new
]

{ #category : #'t - checkable - accessing' }
ToSegment >> rawChecked [

	^ self holder checked
]

{ #category : #'t - checkable - accessing' }
ToSegment >> rawChecked: anObject [

	self holder checked: anObject
]

{ #category : #'t - checkable - group' }
ToSegment >> rawGroup [

	^ self holder group
]

{ #category : #'t - checkable - group' }
ToSegment >> rawGroup: aGroup [

	self holder group: aGroup
]

{ #category : #'t - checkable - private protocol' }
ToSegment >> switchToNextCheckState [
	" redefined here because the check state is driven by the selection "

	self checked: self isChecked not
]

{ #category : #'t - checkable  - protocol' }
ToSegment >> withIndeterminate [

	^ false
]

{ #category : #'t - checkable  - protocol' }
ToSegment >> withIndeterminate: aBoolean [

	self shouldNotImplement 
]
