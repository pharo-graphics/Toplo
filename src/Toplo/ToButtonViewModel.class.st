Class {
	#name : #ToButtonViewModel,
	#superclass : #ToBasicButtonViewModel,
	#category : #'Toplo-Widget-Buttons'
}

{ #category : #accessing }
ToButtonViewModel >> iconImage: anElement [

	iconViewModel image: anElement
]

{ #category : #'api - hooks' }
ToButtonViewModel >> onInstalledOnlyMeIn: aToButton [

	super onInstalledOnlyMeIn: aToButton
]
