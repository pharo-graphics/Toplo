Class {
	#name : #ToTreeElementTest,
	#superclass : #TestCase,
	#instVars : [
		'tree'
	],
	#category : #'Toplo-Widget-Tree-Tests-Core'
}

{ #category : #running }
ToTreeElementTest >> setUp [
	super setUp.
	tree := ToTreeElement new.
]
