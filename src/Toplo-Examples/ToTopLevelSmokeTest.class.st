Class {
	#name : #ToTopLevelSmokeTest,
	#superclass : #ToExamplesSmokeTest,
	#instVars : [
		'exampleClass'
	],
	#category : #'Toplo-Examples-TopLevel'
}

{ #category : #'building suites' }
ToTopLevelSmokeTest class >> testParameters [

	^ super testParameters * (ParametrizedTestMatrix new
		  forSelector: #exampleClass
		  addOptions: self topLevelClasses)
]

{ #category : #accessing }
ToTopLevelSmokeTest class >> topLevelClasses [

	^ { ToExLoginPage. ToExMiniBrowser. ToExWorkspace }
]

{ #category : #accessing }
ToTopLevelSmokeTest >> exampleClass [

	^ exampleClass
]

{ #category : #accessing }
ToTopLevelSmokeTest >> exampleClass: aClass [

	exampleClass := aClass
]

{ #category : #tests }
ToTopLevelSmokeTest >> testSmoke [

	[
		self exampleClass open.
		self settleNonInitialSpaces
	] ensure: [
		self closeNonInitialSpaces ]
]
