Class {
	#name : #ToSingleSelectResultView,
	#superclass : #ToElement,
	#instVars : [
		'textInputElement'
	],
	#category : #'Toplo-Widget-Select-Single'
}

{ #category : #initialization }
ToSingleSelectResultView >> initialize [ 

	super initialize.
	self layout: BlFrameLayout new.
	self hMatchParent.
	self vFitContent
]

{ #category : #accessing }
ToSingleSelectResultView >> selectedDataTextField [

	^ textInputElement selectedDataTextField
]

{ #category : #accessing }
ToSingleSelectResultView >> textInputElement: aTextInputElement [

	textInputElement  := aTextInputElement
]
