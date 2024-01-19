Class {
	#name : #ToMonoSelectHeaderNode,
	#superclass : #ToSelectHeaderNode,
	#instVars : [
		'selectedDataTextField',
		'inputTextField',
		'textInput'
	],
	#category : #'Toplo-Widget-Select-Node'
}

{ #category : #initialization }
ToMonoSelectHeaderNode >> initialize [ 

	super initialize.
	middleContainer layout: BlFrameLayout new.
	middleContainer padding: (BlInsets right: 3).
	self padding: (BlInsets vertical: 4)
]

{ #category : #accessing }
ToMonoSelectHeaderNode >> inputTextField [ 

	^ textInput inputTextField
]

{ #category : #'api - hooks' }
ToMonoSelectHeaderNode >> onInstalledIn: aSelect [

	
	super onInstalledIn: aSelect.
	self beUnremovable.
	self hMatchParent.
	textInput := ToSelectTextInput new.
	textInput onInstalledIn: aSelect.
	self middleContainer addChild: textInput
]

{ #category : #accessing }
ToMonoSelectHeaderNode >> selectedDataTextField [ 

	^ textInput selectedDataTextField
]
