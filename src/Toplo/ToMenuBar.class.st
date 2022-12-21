Class {
	#name : #ToMenuBar,
	#superclass : #ToElement,
	#instVars : [
		'menus'
	],
	#category : #'Toplo-Widget-Menu'
}

{ #category : #initialize }
ToMenuBar >> initialize [

	super initialize.
	self layout: BlLinearLayout new.
	menus := OrderedCollection new
]
