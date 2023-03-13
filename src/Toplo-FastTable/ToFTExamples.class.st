"
A list of examples. 
See class side.
"
Class {
	#name : #ToFTExamples,
	#superclass : #Object,
	#category : #'Toplo-FastTable-Examples'
}

{ #category : #examples }
ToFTExamples class >> example0 [
	<example>
	| list |
	list := ToFTTableElement new
		size: 300@300;
		dataSource: (ToFTExampleDataSource data: ((Smalltalk allClassesAndTraits
			sorted: [ :a :b | a name < b name]) copyFrom: 1 to: 10));
		yourself.
	list inspect.
	list matchParent.
	list openInInnerWindow
]

{ #category : #examples }
ToFTExamples class >> example1 [
	<example>
	| list |

	list := ToFTTableElement new
		size: 300@300;
		dataSource: (ToFTExampleDataSource data: (Smalltalk allClassesAndTraits
			sorted: [ :a :b | a name < b name]));
		yourself.
	list inspect.
	list openInInnerWindow
]

{ #category : #examples }
ToFTExamples class >> example2 [
	<example>
	| list |

	list := ToFTTableElement new
		extent: 300@300;
		dataSource: (ToFTExampleDataSource data: ((Smalltalk allClassesAndTraits
			sorted: [ :a :b | a name < b name])
			first: 10));
		yourself.
	list openInWindow
]

{ #category : #examples }
ToFTExamples class >> exampleDragAndDrop1 [
	"Show drag&drop between two lists"
	<sampleInstance>
	<example>
	| list1 list2 |

	list1 := ToFTTableElement new
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		addColumn: (ToFTColumn id: 'Drag from me!');
		dataSource: (ToFTExampleDataSource data: (Smalltalk allClassesAndTraits sorted: [ :a :b | a name < b name ]));
		dragEnabled: true;
		yourself.

	list2 := ToFTTableElement new
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		addColumn: (ToFTColumn id: 'Drop into me!');
		dataSource: ToFTExampleDropDataSource new;
		dropEnabled: true;
		yourself.

	^ PanelMorph new
		extent: 600@350;
		layoutPolicy: TableLayout new;
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		listDirection: #leftToRight;
		cellPositioning: #topLeft;
		listCentering: #topLeft;
		wrapCentering: #topLeft;
		cellInset: 5;
		borderWidth: 0;
		addMorphBack: list1;
		addMorphBack: list2;
		openInWindow
]

{ #category : #examples }
ToFTExamples class >> exampleDragAndDrop2 [
	"Show drag&drop between two lists, multiple selection"
	<sampleInstance>
	<example>
	| list1 list2 |

	list1 := ToFTTableElement new
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		addColumn: (ToFTColumn id: 'Drag from me!');
		dataSource: (ToFTExampleDataSource data: (Smalltalk allClassesAndTraits sorted: [ :a :b | a name < b name ]));
		dragEnabled: true;
		beMultipleSelection;
		yourself.

	list2 := ToFTTableElement new
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		addColumn: (ToFTColumn id: 'Drop into me!');
		dataSource: ToFTExampleDropDataSource new;
		dropEnabled: true;
		yourself.

	^ PanelMorph new
		extent: 600@350;
		layoutPolicy: TableLayout new;
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		listDirection: #leftToRight;
		cellPositioning: #topLeft;
		listCentering: #topLeft;
		wrapCentering: #topLeft;
		cellInset: 5;
		borderWidth: 0;
		addMorphBack: list1;
		addMorphBack: list2;
		openInWindow
]

{ #category : #examples }
ToFTExamples class >> exampleDragAndDrop3 [
	"Show drag&drop between two lists, multiple selection.
	 Showing 50 elements, so we can test Cmd+A (select all)"
	<sampleInstance>
	<example>
	| list1 list2 |

	list1 := ToFTTableElement new
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		addColumn: (ToFTColumn id: 'Drag from me!');
		dataSource: (ToFTExampleDataSource data: ((Smalltalk allClassesAndTraits sorted: [ :a :b | a name < b name ]) first: 50));
		dragEnabled: true;
		beMultipleSelection;
		yourself.

	list2 := ToFTTableElement new
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		addColumn: (ToFTColumn id: 'Drop into me!');
		dataSource: ToFTExampleDropDataSource new;
		dropEnabled: true;
		yourself.

	^ PanelMorph new
		extent: 600@350;
		layoutPolicy: TableLayout new;
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		listDirection: #leftToRight;
		cellPositioning: #topLeft;
		listCentering: #topLeft;
		wrapCentering: #topLeft;
		cellInset: 5;
		borderWidth: 0;
		addMorphBack: list1;
		addMorphBack: list2;
		openInWindow
]

{ #category : #examples }
ToFTExamples class >> exampleDragAndDrop4 [
	"Show drag&drop in one list, with autoscroll"
	<sampleInstance>
	<example>
	| list |

	list := ToFTTableElement new
		extent: 300@300;
		addColumn: (ToFTColumn id: 'Drag from & to me!');
		dataSource: (ToFTExampleDropDataSource data: (Smalltalk allClassesAndTraits sorted: [ :a :b | a name < b name ]));
		dragEnabled: true;
		dropEnabled: true;
		yourself.

	^ list openInWindowLabeled: 'Autoscrolling'
]

{ #category : #examples }
ToFTExamples class >> exampleEasyList1 [
	"Show an easy list with all Morph methods"
	<sampleInstance>
	<example>
	| list |

	list := ToFTEasyListMorph new
		extent: 300@550;
		data: Morph methods;
		icon: [ :method | (ToFTExampleMethodModel method: method) actionOn: nil ];
		"display: [ :method | method selector ];	"
		yourself.

	^ list openInWindow
]

{ #category : #examples }
ToFTExamples class >> exampleEasyList2 [
	"Show an easy list with all Morph methods and a simple menu"
	<example>
	<sampleInstance>
	| list |

	list := ToFTEasyListMorph new
		extent: 300@550;
		data: Morph methods;
		icon: [ :method | (ToFTExampleMethodModel method: method) actionOn: nil ];
		display: [ :method | method selector ];
		menu: [ :method |
			MenuMorph new
				add: ('Browse #', (method methodClass name), '>>#', method selector)
					target: method
					selector: #browse;
				add: ('Inspect #', (method methodClass name), '>>#', method selector)
					target: method
					selector: #inspect;
				yourself ];
		yourself.

	^ list openInWindow
]

{ #category : #examples }
ToFTExamples class >> exampleEasyList3 [
	"Show an easy list with all Morph methods and a simple menu, with a list header"
	<example>
	<sampleInstance>
	| list |

	list := ToFTEasyListMorph new
		extent: 300@550;
		data: Morph methods;
		header: 'Method list';
		icon: [ :method | (ToFTExampleMethodModel method: method) actionOn: nil ];
		display: [ :method | method selector ];
		menu: [ :method |
			MenuMorph new
				add: ('Browse #', (method methodClass name), '>>#', method selector)
					target: method
					selector: #browse;
				add: ('Inspect #', (method methodClass name), '>>#', method selector)
					target: method
					selector: #inspect;
				yourself ];
		yourself.

	^ list openInWindow
]

{ #category : #examples }
ToFTExamples class >> exampleEditableList1 [
	<sampleInstance>
	<example>
	| list data |
	data := OrderedCollection with: 'A' with: 'B' with: 'C'.
	list := ToFTTableElement new
		extent: 300 @ 550;
		dataSource: (ToFTExampleDropDataSource new data: data);
		selectIndex: 1;
		showFirstSelection;
		onAnnouncement: ToFTStrongSelectionChanged
			do: [ :ann |
			| index morph ed |
			index := ann selectedIndex.
			morph := list visibleRowMorphAtIndex: index.
			ed := RubFloatingEditorBuilder new
				customizeEditorWith: [ :editor |
					editor scrollbarsShowNever.
					editor
						bounds:
							(morph bounds
								insetBy:
									(Margin
										left: -2
										top: 0
										right: 0
										bottom: 0)) ];
				withEditedContentsDo: [ :editedContents |
					data at: index put: editedContents asString.
					list refresh ].
			ed openEditorWithContents: (data at: index) ];
		yourself.

	^ list openInWindow
]

{ #category : #examples }
ToFTExamples class >> exampleFilterableList [
	<example>
	| list |
	list := ToFTTableElement new
		extent: 300 @ 300;
		dataSource:
			(ToFTExampleDataSource data: (Smalltalk allClassesAndTraits sorted: [ :a :b | a name < b name ]));
		enableFilter;
		yourself.
	list openInWindow
]

{ #category : #examples }
ToFTExamples class >> exampleList1 [
	"Show a list with all Object methods"
	<example>
	<sampleInstance>
	| list |

	list := ToFTTableElement new
		extent: 300@550;
		dataSource: (ToFTExampleMethodListDataSource for: Object);
		yourself.

	^ list openInWindow
]

{ #category : #examples }
ToFTExamples class >> exampleList2 [
	"Show a list with all Object methods and preselects one item"

	<example>
	<sampleInstance>
	| list |
	list := ToFTTableElement new
		extent: 300 @ 550;
		dataSource: (ToFTExampleMethodListDataSource for: Object);
		selectIndex: 42;
		showFirstSelection;
		allowDeselection;
		yourself.

	^ list openInWindow
]

{ #category : #examples }
ToFTExamples class >> exampleList3 [
	"Show a list with all Object methods,
		- preselects one element
	 	- responds to selection changes"

	<example>
	<sampleInstance>
	| list |
	list := ToFTTableElement new
		extent: 300 @ 550;
		dataSource: (ToFTExampleMethodListDataSource for: Object);
		selectIndex: 42;
		showFirstSelection;
		onAnnouncement: ToFTSelectionChanged do: [ :ann | ('row selected: ' , ann newSelectedIndexes asString) crTrace ];
		yourself.

	^ list openInWindow
]

{ #category : #examples }
ToFTExamples class >> exampleList4 [
	"Show a list with all Object methods,
		- preselects one element
		- respond to selection changes
		- respond to strong selections (double click)"

	<sampleInstance>
	<example>
	| list |
	list := ToFTTableElement new
		extent: 300 @ 550;
		dataSource: (ToFTExampleMethodListDataSource for: Object);
		selectIndex: 42;
		showFirstSelection;
		onAnnouncement: ToFTSelectionChanged
			do: [ :ann | ('row selected: ' , ann newSelectedIndexes asString) crTrace ];
		onAnnouncement: ToFTStrongSelectionChanged
			do:
				[ :ann | ('double-click on row: ' , ann selectedIndex asString) crTrace ];
		yourself.
	^ list openInWindow
]

{ #category : #examples }
ToFTExamples class >> exampleList5 [
	"Show a list with all Object methods,
		- preselects one element
		- respond to selection changes
		- respond to strong selections (double click)
		- allows multiple selection"

	<sampleInstance>
	<example>
	| list |
	list := ToFTTableElement new
		extent: 300 @ 550;
		dataSource: (ToFTExampleMethodListDataSource for: Object);
		selectIndexes: #(42 43);
		showFirstSelection;
		onAnnouncement: ToFTSelectionChanged do: [ :ann | ('rows selected: ' , ann newSelectedIndexes asString) crTrace ];
		onAnnouncement: ToFTStrongSelectionChanged do: [ :ann | ('double-click on row: ' , ann selectedIndex asString) crTrace ];
		beMultipleSelection;
		yourself.

	^ list openInWindow
]

{ #category : #'function examples' }
ToFTExamples class >> exampleListWithExplicitFilter [
	<example>
	| list |
	list := ToFTTableElement new
		extent: 300 @ 300;
		dataSource: (ToFTExampleDataSource data: (Smalltalk allClassesAndTraits sorted: [ :a :b | a name < b name ]));
		enableFilter;
		explicitFunction;
		yourself.
	list openInWindow
]

{ #category : #'function examples' }
ToFTExamples class >> exampleListWithExplicitFilterAndActionButton [
	<example>
	| list |
	list := ToFTTableElement new
		extent: 300 @ 300;
		dataSource:
			(ToFTExampleDataSource
				data: (Smalltalk allClassesAndTraits sorted: [ :a :b | a name < b name ]));
		enableFilterWithAction: [ :dataSource :searchPattern | self crTrace: searchPattern ]
			named: 'Show';
		yourself.
	list openInWindow
]

{ #category : #'function examples' }
ToFTExamples class >> exampleListWithExplicitFilterAndActionButton2 [
	<example>
	| list |
	list := ToFTTableElement new
		extent: 300 @ 300;
		dataSource: (ToFTExampleDataSource data: (Smalltalk allClassesAndTraits sorted: [ :a :b | a name < b name ]));
		enableFilterWithAction: [ :dataSource :searchPattern :selectedRow | selectedRow browse ];
		yourself.
	list openInWindow
]

{ #category : #'function examples' }
ToFTExamples class >> exampleListWithExplicitSearch [
	<example>
	| list |
	list := ToFTTableElement new
		extent: 300 @ 300;
		dataSource:
			(ToFTExampleDataSource data: (Smalltalk allClassesAndTraits sorted: [ :a :b | a name < b name ]));
		explicitFunction;
		yourself.
	list openInWindow
]

{ #category : #examples }
ToFTExamples class >> exampleListWithGenerator [
	"Show a list with all Object methods"
	<example>
	<sampleInstance>
	| list |

	list := ToFTTableElement new
		extent: 300@550;
		dataSource: (ToFTExampleMethodListGeneratorDataSource for: Object);
		yourself.

	^ list openInWindow
]

{ #category : #examples }
ToFTExamples class >> exampleListWithHeader [
	"Show a list with all Object methods with a header"

	<example>
	<sampleInstance>
	| list |
	list := ToFTTableElement new
		extent: 300 @ 550;
		addColumn: (ToFTColumn id: 'Method name');
		dataSource: (ToFTExampleMethodListDataSource for: Object);
		yourself.

	^ list openInWindow
]

{ #category : #examples }
ToFTExamples class >> exampleOutline1 [
	<example>
	| list |
	list := ToFTTableElement new
		extent: 200 @ 400;
		dataSource:
			(ToFTOutlineDataSource
				items:
					{(1 to: 10).
					(11 to: 20).
					(21 to: 30).
					(31 to: 40).
					(41 to: 50)}).
	list openInWindow
]

{ #category : #examples }
ToFTExamples class >> exampleOutline2 [
	<example>
	| data list |
	data := OrderedCollection
		withAll:
			(Morph allSubclasses
				collect: [ :each | each allSubclasses sorted: [ :a :b | a name < b name ] ]).
	list := ToFTTableElement new
		extent: 300 @ 300;
		dataSource: (ToFTOutlineDataSource items: data).
	list openInWindow
]

{ #category : #examples }
ToFTExamples class >> exampleRowNotHomogeneousList1 [
	"Show a list with all Object methods"
	<example>
	| list |

	list := ToFTTableElement new
		extent: 300@550;
		beRowNotHomogeneous;
		dataSource: (ToFTExampleMethodNotHomogeneousListDataSource for: Object);
		yourself.

	^ list openInWindow
]

{ #category : #examples }
ToFTExamples class >> exampleSortableList [
	"Show a list with all Object methods with a header"

	<example>
	<sampleInstance>
	| list |
	list := ToFTTableElement new
		extent: 300 @ 550;
		addColumn:
			((ToFTColumn id: 'Class name')
				sortableOnProperty: #printString;
				yourself);
		dataSource: (ToFTExampleDataSource data: Smalltalk allClassesAndTraits shuffled);
		yourself.

	^ list openInWindow
]

{ #category : #examples }
ToFTExamples class >> exampleSortableList2 [
	"Show a list with all Object methods with a header"

	<example>
	<sampleInstance>
	| list |
	list := ToFTTableElement new
		extent: 300 @ 550;
		addColumn:
			((ToFTColumn id: 'Class name')
				sortableUsing: #printString ascending;
				yourself);
		dataSource: (ToFTExampleDataSource data: Smalltalk allClassesAndTraits shuffled);
		yourself.

	^ list openInWindow
]

{ #category : #examples }
ToFTExamples class >> exampleSortableTable1 [
	"Show a table with all Object methods"

	<sampleInstance>
	<example>
	| table |
	table := ToFTTableElement new
		extent: 650 @ 500;
		addColumn:
			((ToFTColumn id: 'Name')
				sortableOnProperty: #name;
				yourself);
		addColumn:
			((ToFTColumn id: 'Protocol')
				sortableOnProperty: #protocol;
				yourself);
		addColumn:
			((ToFTColumn id: 'Origin')
				sortableOnProperty: [ :entity | entity origin name ];
				yourself);
		dataSource: (ToFTExampleMethodTableDataSource for: Object);
		selectFirst;
		showFirstSelection;
		onAnnouncement: ToFTSelectionChanged do: [ :ann | ('rows selected: ' , ann newSelectedIndexes asString) crTrace ];
		onAnnouncement: ToFTStrongSelectionChanged do: [ :ann | ('double-click on row: ' , ann selectedIndex asString) crTrace ];
		beMultipleSelection;
		beResizable;
		yourself.

	^ table openInWindow
]

{ #category : #examples }
ToFTExamples class >> exampleSortableTable2 [
	"Show a table with all Object methods"

	<sampleInstance>
	<example>
	| table |
	table := ToFTTableElement new
		extent: 650 @ 500;
		addColumn:
			((ToFTColumn id: 'Icon')
				width: 40;
				yourself);
		addColumn:
			((ToFTColumn id: 'Name')
				sortableOnProperty: #name;
				yourself);
		addColumn:
			((ToFTColumn id: 'Number of methods')
				sortableOnProperty: #numberOfMethods;
				yourself);
		addColumn:
			((ToFTColumn id: 'Number of instance variables')
				sortableOnProperty: #instSize;
				yourself);
		dataSource: ToFTExampleClassInfoTableDataSource new;
		selectFirst;
		showFirstSelection;
		beResizable;
		yourself.

	^ table openInWindow
]

{ #category : #examples }
ToFTExamples class >> exampleSortableTable3 [
	"Show a table with all Object methods"

	<sampleInstance>
	<example>
	| table |
	table := ToFTTableElement new
		extent: 650 @ 500;
		addColumn:
			((ToFTColumn id: 'Icon')
				width: 40;
				yourself);
		addColumn:
			((ToFTColumn id: 'Name')
				sortableUsing: #name ascending;
				yourself);
		addColumn:
			((ToFTColumn id: 'Number of methods')
				sortableUsing: #numberOfMethods ascending , #name ascending; "Sort by number of methods, if the same, sort by name."
				yourself);
		addColumn:
			((ToFTColumn id: 'Number of instance variables')
				sortableUsing: #instSize ascending , #name ascending; "Sort by number of inst var, if the same, sort by name."
				yourself);
		dataSource: ToFTExampleClassInfoTableDataSource new;
		selectFirst;
		showFirstSelection;
		beResizable;
		yourself.

	^ table openInWindow
]

{ #category : #examples }
ToFTExamples class >> exampleSortableTree [
	"Show a list with all Object methods with a header"

	<example>
	<sampleInstance>
	| ds |
	ds := ToFTTreeDataSource roots: (ProtoObject allSubclasses reject: [ :e | e isMeta ]) children: [ :data | data subclasses ].
	ToFTTableElement new
		extent: 200 @ 400;
		addColumn:
			((ToFTColumn id: 'Class name')
				sortableOnProperty: #printString;
				yourself);
		dataSource: ds;
		openInWindow
]

{ #category : #examples }
ToFTExamples class >> exampleTable1 [
	"Show a table with all Object methods"

	<sampleInstance>
	<example>
	| table |
	table := ToFTTableElement new
		extent: 650 @ 500;
		addColumn: (ToFTColumn id: 'Name');
		addColumn: (ToFTColumn id: 'Protocol');
		addColumn: (ToFTColumn id: 'Origin');
		dataSource: (ToFTExampleMethodTableDataSource for: Object);
		selectFirst;
		showFirstSelection;
		onAnnouncement: ToFTSelectionChanged do: [ :ann | ('rows selected: ' , ann newSelectedIndexes asString) crTrace ];
		onAnnouncement: ToFTStrongSelectionChanged do: [ :ann | ('double-click on row: ' , ann selectedIndex asString) crTrace ];
		beMultipleSelection;
		beResizable;
		yourself.

	^ table openInWindow
]

{ #category : #examples }
ToFTExamples class >> exampleTable2 [
	"Show a table with all Object methods, with a fixed width"

	<sampleInstance>
	<example>
	| table |
	table := ToFTTableElement new
		extent: 650 @ 500;
		addColumn: ((ToFTColumn id: 'Name') width: 350);
		addColumn: (ToFTColumn id: 'Protocol');
		addColumn: (ToFTColumn id: 'Origin');
		dataSource: (ToFTExampleMethodTableDataSource for: Morph);
		selectFirst;
		showFirstSelection;
		onAnnouncement: ToFTSelectionChanged do: [ :ann | ('rows selected: ' , ann newSelectedIndexes asString) crTrace ];
		onAnnouncement: ToFTStrongSelectionChanged do: [ :ann | ('double-click on row: ' , ann selectedIndex asString) crTrace ];
		beMultipleSelection;
		beResizable;
		yourself.

	^ table openInWindow
]

{ #category : #examples }
ToFTExamples class >> exampleTable3 [
	"Show a table with all Object methods, with a header"

	<sampleInstance>
	<example>
	| table |
	table := ToFTTableElement new
		extent: 650 @ 500;
		addColumn: ((ToFTColumn id: '#') width: 40);
		addColumn: ((ToFTColumn id: 'Name') width: 350);
		addColumn: (ToFTColumn id: 'Protocol');
		addColumn: (ToFTColumn id: 'Origin');
		intercellSpacing: 1;
		dataSource: (ToFTExampleMethodTableDataSource for: Morph);
		selectFirst;
		showFirstSelection;
		onAnnouncement: ToFTSelectionChanged do: [ :ann | ('rows selected: ' , ann newSelectedIndexes asString) crTrace ];
		onAnnouncement: ToFTStrongSelectionChanged do: [ :ann | ('double-click on row: ' , ann selectedIndex asString) crTrace ];
		beMultipleSelection;
		beResizable;
		yourself.

	^ table openInWindow
]

{ #category : #examples }
ToFTExamples class >> exampleTable4 [
	"Show a table with all Object methods, with a resizable header"

	<sampleInstance>
	<example>
	| table |
	table := ToFTTableElement new
		extent: 650 @ 500;
		addColumn: ((ToFTColumn id: '#') width: 40);
		addColumn: ((ToFTColumn id: 'Name') width: 350);
		addColumn: (ToFTColumn id: 'Protocol');
		addColumn: (ToFTColumn id: 'Origin');
		hideColumnHeaders;
		beResizable;
		intercellSpacing: 8 @ 1;
		dataSource: (ToFTExampleMethodTableDataSource for: Morph);
		selectFirst;
		showFirstSelection;
		onAnnouncement: ToFTSelectionChanged do: [ :ann | ('rows selected: ' , ann newSelectedIndexes asString) crTrace ];
		onAnnouncement: ToFTStrongSelectionChanged do: [ :ann | ('double-click on row: ' , ann selectedIndex asString) crTrace ];
		beMultipleSelection;
		beResizable;
		yourself.

	^ table openInWindow
]

{ #category : #examples }
ToFTExamples class >> exampleTable5 [
	"Show a table with cell selection mode"

	<sampleInstance>
	<example>
	| table ds |
	ds := ToFTExampleMethodTableDataSource for: Object.
	table := ToFTTableElement new
		extent: 650 @ 500;
		beCellSelection;
		addColumn: (ToFTColumn id: 'Name');
		addColumn: (ToFTColumn id: 'Protocol');
		addColumn: (ToFTColumn id: 'Origin');
		dataSource: ds;
		selectFirst;
		beMultipleSelection;
		showFirstSelection;
		yourself.
	^ table openInWindow
]

{ #category : #examples }
ToFTExamples class >> exampleTableHorizontalScroll [
	"Show a table with all Object methods, with a header,
	 all fixed width columns as horizontal scroll."

	"self exampleTableHorizontalScroll"

	<example>
	| table |
	table := ToFTTableElement newWithHorizontalScrollBar
		extent: 650 @ 500;
		addColumn: ((ToFTColumn id: '#') width: 40);
		addColumn: ((ToFTColumn id: 'Name') width: 350);
		addColumn: ((ToFTColumn id: 'Protocol') width: 200);
		addColumn: ((ToFTColumn id: 'Origin') width: 200);
		intercellSpacing: 1;
		dataSource: (ToFTExampleMethodTableDataSource for: Morph);
		selectFirst;
		showFirstSelection;
		onAnnouncement: ToFTSelectionChanged do: [ :ann | ('rows selected: ' , ann newSelectedIndexes asString) crTrace ];
		onAnnouncement: ToFTStrongSelectionChanged do: [ :ann | ('double-click on row: ' , ann selectedIndex asString) crTrace ];
		beMultipleSelection;
		yourself.

	^ table openInWindow
]

{ #category : #'tree examples' }
ToFTExamples class >> exampleTree1 [
	<example>
	| ds |
	ds := ToFTTreeDataSource
		roots:
			((Collection allSubclasses reject: [ :e | e name endsWith: 'class' ])
				sort: [ :a :b | a name < b name ])
		children: [ :data | data subclasses sort: [ :a :b | a name < b name ] ].
	ToFTTableElement new
		extent: 200 @ 400;
		dataSource: ds;
		openInWindow
]

{ #category : #'tree examples' }
ToFTExamples class >> exampleTree2 [
	<example>
	| ds |
	ds := ToFTTreeDataSource
		roots: (1 to: 1000)
		children: [ :data :item |
			item depth even
				ifTrue: [ 1 to: data / 2 ]
				ifFalse: [ 1 to: data - 1 ] ].
	ToFTTableElement new
		extent: 200 @ 400;
		dataSource: ds;
		openInWindow
]

{ #category : #'tree examples' }
ToFTExamples class >> exampleTreeWithAllItemsFilter [
	<example>
	| ds |
	ds := ToFTTreeDataSource
		roots: (1 to: 10)
		children: [ :data :item |
			item depth even
				ifTrue: [ 1 to: data / 2 ]
				ifFalse: [ 1 to: data - 1 ] ].
	ds searchStrategy: #allItems.
	ToFTTableElement new
		extent: 200 @ 400;
		dataSource: ds;
		enableFilter;
		explicitFunction;
		openInWindow
]

{ #category : #'tree examples' }
ToFTExamples class >> exampleTreeWithAllItemsSearch [
	<example>
	| ds |
	ds := ToFTTreeDataSource
		roots: (1 to: 10)
		children: [ :data :item |
			item depth even
				ifTrue: [ 1 to: data / 2 ]
				ifFalse: [ 1 to: data - 1 ] ].
	ds searchStrategy: #allItems.
	ToFTTableElement new
		extent: 200 @ 400;
		dataSource: ds;
		explicitFunction;
		openInWindow
]

{ #category : #'tree examples' }
ToFTExamples class >> exampleTreeWithRootFilter [
	<example>
	| ds |
	ds := ToFTTreeDataSource
		roots: (1 to: 1000)
		children: [ :data :item |
			item depth even
				ifTrue: [ 1 to: data / 2 ]
				ifFalse: [ 1 to: data - 1 ] ].
	ds searchStrategy: #rootsOnly.
	ToFTTableElement new
		extent: 200 @ 400;
		dataSource: ds;
		enableFilter;
		explicitFunction;
		openInWindow
]

{ #category : #'tree examples' }
ToFTExamples class >> exampleTreeWithRootSearch [
	<example>
	| ds |
	ds := ToFTTreeDataSource
		roots: (1 to: 1000)
		children: [ :data :item |
			item depth even
				ifTrue: [ 1 to: data / 2 ]
				ifFalse: [ 1 to: data - 1 ] ].
	ds searchStrategy: #rootsOnly.
	ToFTTableElement new
		extent: 200 @ 400;
		dataSource: ds;
		explicitFunction;
		openInWindow
]

{ #category : #'tree examples' }
ToFTExamples class >> exampleTreeWithVisibleItemsFilter [
	<example>
	| ds |
	ds := ToFTTreeDataSource
		roots: (1 to: 1000)
		children: [ :data :item |
			item depth even
				ifTrue: [ 1 to: data / 2 ]
				ifFalse: [ 1 to: data - 1 ] ].
	ds searchStrategy: #default.	"Optional"
	ToFTTableElement new
		extent: 200 @ 400;
		dataSource: ds;
		enableFilter;
		explicitFunction;
		openInWindow
]

{ #category : #'tree examples' }
ToFTExamples class >> exampleTreeWithVisibleItemsSearch [
	<example>
	| ds |
	ds := ToFTTreeDataSource
		roots: (1 to: 1000)
		children: [ :data :item |
			item depth even
				ifTrue: [ 1 to: data / 2 ]
				ifFalse: [ 1 to: data - 1 ] ].
	ds searchStrategy: #default.	"Optional"
	ToFTTableElement new
		extent: 200 @ 400;
		dataSource: ds;
		explicitFunction;
		openInWindow
]

{ #category : #'tree examples' }
ToFTExamples class >> exampleexampleOneSubLevelTree [
	<example>
	| ds |
	ds := ToFTTreeDataSource
		roots:
			((ProtoObject allSubclasses reject: [ :e | e name endsWith: 'class' ])
				sort: [ :a :b | a name < b name ])
		children: [ :item | item subclasses sort: [ :a :b | a name < b name ] ].
	ds maxDepth: 1.
	ToFTTableElement new
		extent: 200 @ 400;
		dataSource: ds;
		openInWindow
]

{ #category : #'see class side' }
ToFTExamples >> seeClassSide [
]
