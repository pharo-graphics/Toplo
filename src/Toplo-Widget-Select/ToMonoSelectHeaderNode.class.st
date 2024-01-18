Class {
	#name : #ToMonoSelectHeaderNode,
	#superclass : #ToSelectHeaderNode,
	#instVars : [
		'selectedDataTextField',
		'inputTextField'
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

	^ inputTextField
]

{ #category : #'api - hooks' }
ToMonoSelectHeaderNode >> onInstalledIn: aSelectHeaderNodeContainer [

	|  select |
	
	super onInstalledIn: aSelectHeaderNodeContainer.
	select := self selectHolder select.
	self beUnremovable.
	self hMatchParent.
	selectedDataTextField := select mode newTextField.
	selectedDataTextField beReadonlyWithSelection.
	selectedDataTextField withLineWrapping.
	selectedDataTextField hMatchParent.
	inputTextField := select mode newInputTextField.
	inputTextField withLineWrapping.
	inputTextField hMatchParent.
	" the id is set here to avoid that a fake node with a text field with the same id "
	selectedDataTextField id: #selectedDataTextField.
	self middleContainer addChild: selectedDataTextField.
	self middleContainer addChild: inputTextField
]

{ #category : #accessing }
ToMonoSelectHeaderNode >> selectedDataTextField [ 

	^ selectedDataTextField
]
