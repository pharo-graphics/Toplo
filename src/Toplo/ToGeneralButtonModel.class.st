Class {
	#name : #ToGeneralButtonModel,
	#superclass : #ToViewModel,
	#category : #'Toplo-View Models'
}

{ #category : #'api - action' }
ToGeneralButtonModel >> clickEvent: anEvent [

]

{ #category : #'private - accessing - widget' }
ToGeneralButtonModel >> privateWidgetClass [

	^ ToGeneralButton
]

{ #category : #processing }
ToGeneralButtonModel >> toggleStates: aCollectionOfStates [

	self widgetDo: [ :widget | widget toggleStates: aCollectionOfStates ]
]

{ #category : #'api - action' }
ToGeneralButtonModel >> whenActionPerformedDo: aBlock [
	"Inform that the button has been aclicked, and its action has been performed.
	 `aBlock` receive zero arguments."

	self widgetDo: [ :widget | widget whenActionPerformedDo: aBlock ]
]

{ #category : #'api - action' }
ToGeneralButtonModel >> whenClickedDo: aBlock [
	"Inform that the button has been aclicked, and its action has been performed.
	 `aBlock` receive zero arguments."
	
	self widgetDo: [ :widget | widget whenClickedDo: aBlock ]
]
