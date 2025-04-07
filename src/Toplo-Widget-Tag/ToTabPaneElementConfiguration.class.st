Class {
	#name : #ToTabPaneElementConfiguration,
	#superclass : #ToWidgetConfiguration,
	#category : #'Toplo-Widget-Tag-Tab'
}

{ #category : #hook }
ToTabPaneElementConfiguration >> applyOn: aTabPaneElement [

	aTabPaneElement tabGroup horizontal: aTabPaneElement isHorizontal not.
	aTabPaneElement isHorizontal
		ifTrue: [
			aTabPaneElement header
				vMatchParent;
				hFitContent.
			aTabPaneElement tabGroup
				vMatchParent;
				hFitContent ]
		ifFalse: [
			aTabPaneElement header
				hMatchParent;
				vFitContent.
			aTabPaneElement tabGroup
				hMatchParent;
				vFitContent ]
]
