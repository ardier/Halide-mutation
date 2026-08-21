namespace {
int helper_free_function() {
    int x = 1;
    return x;
}
class Foo {
public:
    void generate() { int y = 2; }
    void generate2();
};
void Foo::generate2() { int z = 3; }
}
int top_level_free() { int w = 4; return w; }
