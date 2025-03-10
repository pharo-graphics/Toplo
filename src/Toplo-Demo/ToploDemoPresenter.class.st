Class {
	#name : #ToploDemoPresenter,
	#superclass : #BlDemoPresenter,
	#category : #'Toplo-Demo'
}

{ #category : #demos }
ToploDemoPresenter class >> demo1 [

	<demo>

	^ ToAlbum new
		withRowNumbers;
		text: String loremIpsum asRopedText;
		yourself
]

{ #category : #demos }
ToploDemoPresenter class >> demo2 [

	<demo>
	| list colorAssociations |
	(list := ToListElement new) nodeBuilder: [ :node :dataItem :holder |
		node addChild: (ToLabeledIcon new
				 label: (ToLabel new
						  text: dataItem key;
						  yourself);
				 icon: (ToElement new
						  size: 50 @ 25;
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
					                     -> (color perform: transformationSelector) ] ] ].
	list dataAccessor addAll: colorAssociations.
	^ list
]

{ #category : #demos }
ToploDemoPresenter class >> demo3 [

	<demo>
	| containerElement checkableGroup lightThemeBtn darkThemeBtn |
	(containerElement := ToPane vertical) padding: (BlInsets all: 10).
	(checkableGroup := ToCheckableGroup new)
		withStrictCheckingStrategy;
		registerAll: {
				(lightThemeBtn := ToRadioButton new
					                  id: #r1;
					                  labelText: 'Light theme';
					                  yourself).
				(darkThemeBtn := ToRadioButton new
					                 id: #r2;
					                 labelText: 'Dark theme';
					                 yourself) }.

	containerElement
		newCheckGroupAction: [ :evt :grp :list |
			list first = lightThemeBtn
				ifTrue: [ containerElement space toTheme: ToRawTheme new ]
				ifFalse: [ containerElement space toTheme: ToRawDarkTheme new ] ]
		with: checkableGroup.
		
	checkableGroup registeredCheckables second checked: true.
	containerElement addChildren: checkableGroup registeredCheckables.
	^ containerElement
]

{ #category : #running }
ToploDemoPresenter class >> menuCommandOn: aBuilder [

	<worldMenu>

	(aBuilder item: #'Open Toplo Demo')
		action: [ self open ];
		parent: #Help;
		iconName: #group;
		withSeparatorAfter
]

{ #category : #running }
ToploDemoPresenter class >> open [

	<script>

	super open
]

{ #category : #private }
ToploDemoPresenter >> drawOnCanvas: anElement [

	self canva space toTheme: ToRawTheme new.
	super drawOnCanvas: anElement.
]

{ #category : #accessing }
ToploDemoPresenter >> packagesToCollect [

	^ self packageOrganizer packages select: [ :package |
		package name includesSubstring: 'Toplo' ]
]

{ #category : #accessing }
ToploDemoPresenter >> title [

	^ 'Toplo Demo'
]
