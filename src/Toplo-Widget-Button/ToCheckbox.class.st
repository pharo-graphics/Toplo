Class {
	#name : #ToCheckbox,
	#superclass : #ToButtonDep,
	#traits : 'TToCheckable + TToCheckbox',
	#classTraits : 'TToCheckable classTrait + TToCheckbox classTrait',
	#category : #'Toplo-Widget-Button-Checkable'
}

{ #category : #initialization }
ToCheckbox >> defaultEventHandler [ 

	^ ToCheckableEventHandler new 
]

{ #category : #'t - skinable - initialization' }
ToCheckbox >> defaultStyleStamps [

	^ { #button. #checkable. #checkbox}
]
