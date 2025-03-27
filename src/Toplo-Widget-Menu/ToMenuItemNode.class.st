Class {
	#name : #ToMenuItemNode,
	#superclass : #ToItemNode,
	#category : #'Toplo-Widget-Menu-ItemBar'
}

{ #category : #'instance creation' }
ToMenuItemNode >> newWidgetConfiguration [

	^ ToConfigurationAction new action: [ :aNode |
		  aNode holder dataItem constraintMenuNode: aNode ]
]
