Class {
	#name : #ToBasicButton,
	#superclass : #ToWidget,
	#traits : 'TOBlLayoutResizable',
	#classTraits : 'TOBlLayoutResizable classTrait',
	#category : #'Toplo-Widget-Buttons'
}

{ #category : #'mouse handlers' }
ToBasicButton >> clickEvent: anEvent [

	self isDisabled ifTrue: [ ^ self ].
	anEvent consumed: true.
	anEvent currentTarget: self.
	self viewModel clickEvent: anEvent.
	self viewModel announce: (ToButtonLaunchClickAction new widget: self).
	self viewModel announce: (ToButtonActionPerformed new widget: self).

]

{ #category : #initialization }
ToBasicButton >> defaultViewModel [ 

	^ ToBasicButtonModel new
]

{ #category : #'api-  action' }
ToBasicButton >> whenActionPerformedDo: aBlock [
	"Inform that the button has been aclicked, and its action has been performed.
	 `aBlock` receive zero arguments."

	self viewModel whenActionPerformedDo: aBlock
]

{ #category : #'api-  action' }
ToBasicButton >> whenClickedDo: aBlock [

	self viewModel whenClickedDo: aBlock
]
