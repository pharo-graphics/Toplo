Class {
	#name : #ToDemoPresenter,
	#superclass : #BlDemoPresenter,
	#category : #'Toplo-Demo-Presenter'
}

{ #category : #demos }
ToDemoPresenter class >> demo1 [
	<demo>

	^ ToAlbum new
		withRowNumbers;
		text: String loremIpsum asRopedText;
		yourself
]

{ #category : #demos }
ToDemoPresenter class >> demo2 [
	<demo>

	| list colorAssociations |
	(list := ToListElement new) nodeBuilder: [ :node :dataItem :holder |
			node addChild: (ToLabeledIcon new
					 label: (ToLabel new
							  text: dataItem key;
							  yourself);
					 icon: (ToElement new
							  extent: 50 @ 25;
							  background: dataItem value;
							  yourself);
					 startInterspace: 3;
					 yourself) ].

	colorAssociations := Array streamContents: [ :stream |
			                     Color registeredColorNames sorted do: [
					                     :colorName |
					                     | color expression |
					                     color := Color named: colorName.
					                     expression := color printString.
					                     stream nextPut: expression -> color.
					                     #( lighter twiceLighter whiter paler darker
					                        twiceDarker blacker duller ) do: [
							                     :transformationSelector |
							                     stream nextPut: ('{1} {2}' format: {
										                      expression.
										                      transformationSelector })
								                     ->
								                     (color perform: transformationSelector) ] ] ].
	list dataAccessor addAll: colorAssociations.
	^ list
]

{ #category : #demos }
ToDemoPresenter class >> demo3 [

	<demo>
	| containerElement |
	containerElement := ToCheckableGroupPane vertical.
	{
		ToRawTheme.
		ToRawDarkTheme } do: [ :themeClass |
			containerElement addChild: (ToRadioButton new
					 labelText: themeClass label;
					 in: [ :rad | rad userData at: #themeClass put: themeClass ];
					 yourself) ].
				
	containerElement groupCheckAction: [ :evt |
			containerElement space toTheme:
				(evt checkedList anyOne userData at: #themeClass) new ].

	containerElement children second checked: true.

	^ containerElement
]

{ #category : #running }
ToDemoPresenter class >> menuCommandOn: aBuilder [
	<worldMenu>

	(aBuilder item: #'Toplo demo browser')
		parent: #ToploExamples;
		order: 0.1;
		action: [ self open ];
		iconName: #go
]

{ #category : #running }
ToDemoPresenter class >> open [
	<script>

	super open
]

{ #category : #private }
ToDemoPresenter >> drawOnCanvas: anElement [

	self canva space toTheme: ToRawTheme new.
	super drawOnCanvas: anElement.
]

{ #category : #accessing }
ToDemoPresenter >> packagesToCollect [

	^ self packageOrganizer packages select: [ :package |
		package name includesSubstring: 'Toplo' ]
]

{ #category : #accessing }
ToDemoPresenter >> title [

	^ 'Toplo Demo'
]
