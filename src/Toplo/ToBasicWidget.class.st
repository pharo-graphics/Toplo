Class {
	#name : #ToBasicWidget,
	#superclass : #ToWidget,
	#traits : 'TObservable',
	#classTraits : 'TObservable classTrait',
	#instVars : [
		'viewModel'
	],
	#category : #'Toplo-Core'
}

{ #category : #initialization }
ToBasicWidget >> defaulViewModel [

	^ self subclassResponsibility
]

{ #category : #initialization }
ToBasicWidget >> initialize [
	
	self class initializeSlots: self.
	super initialize.
]

{ #category : #accessing }
ToBasicWidget >> viewModel [

	^ viewModel
]

{ #category : #accessing }
ToBasicWidget >> viewModel: aViewModel [

	self viewModelDo: [ :aCurrentModel | aCurrentModel onUninstalledIn: self ].
	viewModel := aViewModel.
	self viewModelDo: [ :aCurrentModel | aViewModel onInstalledIn: self ]
]

{ #category : #enumerating }
ToBasicWidget >> viewModelDo: aBlock [
	viewModel ifNotNil: aBlock
]
