Class {
	#name : #ToSingleSelectHeaderNode,
	#superclass : #ToSelectHeaderNode,
	#instVars : [
		'selectedDataTextField',
		'inputTextField',
		'textInputElement'
	],
	#category : #'Toplo-Widget-Select-Node'
}

{ #category : #initialization }
ToSingleSelectHeaderNode >> initialize [ 

	super initialize.
	middleContainer layout: BlFrameLayout new
]

{ #category : #skin }
ToSingleSelectHeaderNode >> installRawStyle [ 

	super installRawStyle.
	middleContainer padding: (BlInsets right: 3).
	self padding: (BlInsets vertical: 4)
]

{ #category : #'api - hooks' }
ToSingleSelectHeaderNode >> onInstalledIn: aSelect [

	super onInstalledIn: aSelect.
	self beUnremovable.
	self hMatchParent.
	textInputElement := ToSelectTextInputElement new.
	textInputElement onInstalledIn: aSelect.
	self middleContainer addChild: textInputElement
]

{ #category : #'api - hooks' }
ToSingleSelectHeaderNode >> onUninstalledIn: aSelect [

	textInputElement onUninstalledIn: aSelect.
	self middleContainer removeChild: textInputElement.
	super onUninstalledIn: aSelect.

]

{ #category : #accessing }
ToSingleSelectHeaderNode >> textInputElement [ 

	^ textInputElement 
]
