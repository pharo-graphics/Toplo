Class {
	#name : #ToMenuItemNode,
	#superclass : #ToItemNode,
	#category : #'Toplo-Widget-Menu-ItemBar'
}

{ #category : #configuration }
ToMenuItemNode >> applyWidgetConfiguration [

	super applyWidgetConfiguration.
	self holder dataItem constraintMenuNode: self
]
