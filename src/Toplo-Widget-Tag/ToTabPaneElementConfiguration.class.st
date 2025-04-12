Class {
	#name : #ToTabPaneElementConfiguration,
	#superclass : #ToWidgetConfiguration,
	#category : #'Toplo-Widget-Tag-Tab'
}

{ #category : #hook }
ToTabPaneElementConfiguration >> applyOn: aTabPaneElement [

	aTabPaneElement tabGroup horizontal: aTabPaneElement isHorizontal not.
	aTabPaneElement atStartSide
		ifTrue: [ aTabPaneElement beStartToEnd ]
		ifFalse: [ aTabPaneElement beEndToStart ].
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
