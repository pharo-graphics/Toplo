Class {
	#name : #ToAccordionBaseElement,
	#superclass : #ToAccordionAbstractElement,
	#category : #'Toplo-Widget-Accordion-Core'
}

{ #category : #examples }
ToAccordionBaseElement class >> exampleSeveralInCheckableGroup [

	<script>
	| pane group |
	pane := ToPane new.
	pane layout: BlLinearLayout vertical.
	pane hMatchParent.
	group := ToCheckableGroup new.
	pane vFitContent.
	(1 to: 5) collect: [ :i |
		pane addChild: ((self itemWithLabelText: 'Header ' , i asString) isExpanded: false)].
	group registerAll: pane children.
	pane openInSpace.
	^ pane
]

{ #category : #examples }
ToAccordionBaseElement class >> exampleSeveralInPaneWithLabel [

	<script>
	| pane |
	pane := ToPane new.
	pane layout: BlLinearLayout vertical.
	pane hMatchParent.
	pane vFitContent.
	(1 to: 5) collect: [ :i |
		pane addChild: ((self itemWithLabelText: 'Header ' , i asString) isExpanded: false)].
	pane openInSpace.
	^ pane
]

{ #category : #examples }
ToAccordionBaseElement class >> exampleWithLabel [

	<script>
	| inst |
	inst := self itemWithLabel.
	inst openInSpace.

	^ inst
]

{ #category : #examples }
ToAccordionBaseElement class >> exampleWithLabelAndAlbumInBody [

	<script>
	| inst |
	inst := self itemWithLabelAndAlbumInBody.
	inst openInSpace.
	^ inst
]

{ #category : #examples }
ToAccordionBaseElement class >> exampleWithLabelChecked [

	<script>
	| inst |
	inst := self itemWithLabel.
	inst checked: true.
	inst openInSpace.
	^ inst
]

{ #category : #examples }
ToAccordionBaseElement class >> exampleWithLabelExpanded [

	<script>
	| inst |
	inst := self itemWithLabel.
	inst isExpanded: true.
	inst openInSpace.
	^ inst
]

{ #category : #examples }
ToAccordionBaseElement class >> exampleWithLabelNotPreservingBody [

	<script>
	| inst |
	inst := self itemWithLabel.
	inst preserveBody: false.
	inst openInSpace.
	^ inst
]

{ #category : #examples }
ToAccordionBaseElement class >> exampleWithLabelNotPreservingBodyAndExpanded [

	<script>
	| inst |
	inst := self itemWithLabel.
	inst preserveBody: false.
	inst isExpanded: true.
	inst openInSpace.
	^ inst
]

{ #category : #accessing }
ToAccordionBaseElement >> group: aCheckableGroup [

	header group: aCheckableGroup
]

{ #category : #initialization }
ToAccordionBaseElement >> initialize [

	super initialize.
	header addEventHandlerOn: ToCheckableCheckEvent do: [
		self privateExpanded: self isChecked ]
]

{ #category : #testing }
ToAccordionBaseElement >> isChecked [ 
	
	^ header isChecked
]

{ #category : #testing }
ToAccordionBaseElement >> isExpanded [

	^ self isChecked
]

{ #category : #accessing }
ToAccordionBaseElement >> isExpanded: aBoolean [

	header checked: aBoolean
]

{ #category : #'instance creation' }
ToAccordionBaseElement >> newHeader [ 

	^  ToAccordionCheckableHeaderElement new
]

{ #category : #skin }
ToAccordionBaseElement >> newRawSkin [

	^ ToAccordionBaseElementSkin new
]

{ #category : #'t - checkable - group' }
ToAccordionBaseElement >> privateChecked: aBoolean [

	header privateChecked: aBoolean
]

{ #category : #'t - checkable - group' }
ToAccordionBaseElement >> registerInGroup: aGroup [

	header registerInGroup: aGroup
]

{ #category : #'t - checkable - group' }
ToAccordionBaseElement >> unregisterFromGroup [

	header unregisterFromGroup
]
