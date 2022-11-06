Class {
	#name : #ToDisablementLayer,
	#superclass : #ToWidgetLayer,
	#category : #'Toplo-Core'
}

{ #category : #'api - attaching / detaching' }
ToDisablementLayer >> attachTo: anEditorElement from: aviewModel [

	super attachTo: anEditorElement from: aviewModel.	
	self removeEventHandler: delegator 

]

{ #category : #initialization }
ToDisablementLayer >> initialize [

	super initialize.
	self layout: BlFrameLayout new.
	self background: (Color lightGray alpha: 0.3).
]
