Class {
	#name : #ToTableCellElement,
	#superclass : #ToTripletContainer,
	#instVars : [
		'column'
	],
	#category : #'Toplo-Widget-Table-Core'
}

{ #category : #initialization }
ToTableCellElement >> initialize [

	super initialize.
	self createStartContainer.
	self createEndContainer
]

{ #category : #'t - triplet container - instance creation' }
ToTableCellElement >> newEndContainer [

	^ self newLinearContainer
]

{ #category : #'t - triplet container - instance creation' }
ToTableCellElement >> newMiddleContainer [

	^ self newLinearContainer
]

{ #category : #'t - triplet container - instance creation' }
ToTableCellElement >> newStartContainer [

	^ self newLinearContainer
]
