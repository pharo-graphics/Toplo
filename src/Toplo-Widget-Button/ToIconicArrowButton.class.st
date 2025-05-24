Class {
	#name : #ToIconicArrowButton,
	#superclass : #ToIconicButton,
	#instVars : [
		'orientation'
	],
	#category : #'Toplo-Widget-Button-Iconic'
}

{ #category : #accessing }
ToIconicArrowButton class >> down [ 

	^ self new orientation: #down
]

{ #category : #accessing }
ToIconicArrowButton class >> right [ 

	^ self new orientation: #right
]

{ #category : #accessing }
ToIconicArrowButton class >> up [ 

	^ self new orientation: #up
]

{ #category : #initialization }
ToIconicArrowButton >> initialize [ 

	super initialize.
	self newClickAction: [ self fireEvent: ToArrowButtonClickedEvent new ].
	self id: #'arrow-button'.
	orientation := #right
]

{ #category : #accessing }
ToIconicArrowButton >> isDown [

	^ orientation = #down
]

{ #category : #accessing }
ToIconicArrowButton >> isRight [

	^ orientation = #right
]

{ #category : #accessing }
ToIconicArrowButton >> isUp [ 

	^ orientation = #up
]

{ #category : #skin }
ToIconicArrowButton >> newRawSkin [ 

	^ ToIconicArrowButtonSkin new
]

{ #category : #accessing }
ToIconicArrowButton >> orientation: aSymbol [

	orientation = aSymbol ifTrue: [ ^ self ].
	orientation := aSymbol.
	self requestNewSkin
]
