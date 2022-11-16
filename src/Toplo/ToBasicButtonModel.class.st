Class {
	#name : #ToBasicButtonModel,
	#superclass : #ToViewModel,
	#category : #'Toplo-Widget-Buttons'
}

{ #category : #'api - action' }
ToBasicButtonModel >> clickEvent: anEvent [

]

{ #category : #'private - accessing - widget' }
ToBasicButtonModel >> privateWidgetClass [

	^ ToBasicButton
]

{ #category : #processing }
ToBasicButtonModel >> states: aCollectionOfStates [

	self widgetDo: [ :widget | widget states: aCollectionOfStates ]
]

{ #category : #'api - action' }
ToBasicButtonModel >> whenActionPerformedDo: aBlock [
	"Inform that the button has been aclicked, and its action has been performed.
	 `aBlock` receive zero arguments."

	self widgetDo: [ :widget | widget whenActionPerformedDo: aBlock ]
]

{ #category : #'api - action' }
ToBasicButtonModel >> whenClickedDo: aBlock [
	"Inform that the button has been aclicked, and its action has been performed.
	 `aBlock` receive zero arguments."
	
	self widgetDo: [ :widget | widget whenClickedDo: aBlock ]
]
