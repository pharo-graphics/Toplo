Class {
	#name : #ToCommandApplier,
	#superclass : #Object,
	#instVars : [
		'element'
	],
	#category : #'Toplo-Widget-List-Command-Support'
}

{ #category : #accessing }
ToCommandApplier >> command: aCommand addedIn: aSelecter [

	self subclassResponsibility 
]

{ #category : #accessing }
ToCommandApplier >> element: anElement [

	element := anElement
]

{ #category : #'api - hooks' }
ToCommandApplier >> onInstalledIn: aSelecter [

]

{ #category : #'api - hooks' }
ToCommandApplier >> onUninstalledIn: aSelecter [

]
