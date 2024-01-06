Class {
	#name : #ToCheckMenuItem,
	#superclass : #ToMenuItem,
	#traits : 'TToElementWithCheckable',
	#classTraits : 'TToElementWithCheckable classTrait',
	#category : 'Toplo-Widget-Menu-Basic'
}

{ #category : #accessing }
ToCheckMenuItem >> button: aCheckbox [

	super button: aCheckbox.
	self button addEventHandler: (BlEventHandler
			 on: ToCheckableCheckEvent
			 do: [ :event | self dispatchEvent: event ])
]

{ #category : #initialization }
ToCheckMenuItem >> buttonClass [

	^ ToCheckbox
]

{ #category : #'t - checkable - accessing' }
ToCheckMenuItem >> checkable [

	^ self button
]

{ #category : #'t - checkable - accessing' }
ToCheckMenuItem >> checked: aBooleanOrNil [
	" change the checkable state. nil means indeterminate. "

	self checkable checked: aBooleanOrNil
]

{ #category : #testing }
ToCheckMenuItem >> closeOnMouseEvent [

	^ false
]

{ #category : #accessing }
ToCheckMenuItem >> indeterminateChild [

	^ self button indeterminateChild
]

{ #category : #skin }
ToCheckMenuItem >> newRawSkin [ 

	^ ToCheckMenuItemSkin new
]

{ #category : #'t - element with checkable group' }
ToCheckMenuItem >> rawGroup [

	^ self button rawGroup
]

{ #category : #'t - element with checkable group' }
ToCheckMenuItem >> rawGroup: aGroup [

	self button rawGroup: aGroup
]
